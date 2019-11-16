import 'package:dio/dio.dart';
import 'package:flutter_built_value_dio/data/built_value_converter.dart';
import 'package:flutter_built_value_dio/model/serializers.dart';

class DioNetworkCallExecutor {
  final Dio _dio;
  final BuiltValueConverter valueConverter;

  DioNetworkCallExecutor(
    this._dio,
    this.valueConverter,
  );

  Future<BodyType> execute<BodyType, SingleItemType>(
    String path, {
    Map<String, dynamic> queryParameters,
    RequestOptions options,
  }) async {
    options = valueConverter.convertRequest(options);
    final Response _result = await _dio.request(path,
        queryParameters: queryParameters, options: options);
    final result =
        valueConverter.convertResponse<BodyType, SingleItemType>(_result);
    return result.data;
  }
}
