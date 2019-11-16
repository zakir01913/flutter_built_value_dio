import 'package:dio/dio.dart';
import 'package:flutter_built_value_dio/data/built_value_converter.dart';
import 'package:flutter_built_value_dio/data/dio_call_executer.dart';
import 'package:flutter_built_value_dio/data/post_api_service.dart';
import 'package:flutter_built_value_dio/model/built_post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:built_collection/built_collection.dart';

main() {
  Dio dio;
  BuiltValueConverter builtValueConverter;
  DioNetworkCallExecutor dioCallExecutor;
  PostApiService postApiService;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
    builtValueConverter = BuiltValueConverter();
    dioCallExecutor = DioNetworkCallExecutor(
      dio,
      builtValueConverter,
    );

    postApiService = PostApiService(dioCallExecutor);
  });

  test("get post", () async {
    final result = await postApiService.getPosts();

    expect(result, isA<BuiltList<BuiltPost>>());
  });

  test("Post", () async {
    final builtPost = BuiltPost((b) => b
    ..title = "title"
    ..body = "Post body");

    final result = await postApiService.postPost(builtPost);
  });
}
