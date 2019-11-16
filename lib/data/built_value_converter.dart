import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_built_value_dio/model/serializers.dart';

class BuiltValueConverter {
  @override
  RequestOptions convertRequest(RequestOptions options) {
    if (options != null) {
      options.data = serializers.serializeWith(
        serializers.serializerForType(options.data.runtimeType),
        options.data,
      );
    }
    return options;
  }

  Response<BodyType> convertResponse<BodyType, SingleItemType>(
    Response response,
  ) {
    final BodyType data = _convertToCustomObject<SingleItemType>(response.data);
    return Response<BodyType>(
      data: data,
      headers: response.headers,
      request: response.request,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  dynamic _convertToCustomObject<SingleItemType>(dynamic element) {
    if (element is SingleItemType) return element;

    if (element is List)
      return _deserializeListOf<SingleItemType>(element);
    else
      return _deserialize<SingleItemType>(element);
  }

  BuiltList<SingleItemType> _deserializeListOf<SingleItemType>(
    List dynamicList,
  ) {
    return BuiltList<SingleItemType>(
      dynamicList.map((element) => _deserialize<SingleItemType>(element)),
    );
  }

  SingleItemType _deserialize<SingleItemType>(
    Map<String, dynamic> value,
  ) {
    return serializers.deserializeWith(
      serializers.serializerForType(SingleItemType),
      value,
    );
  }
}
