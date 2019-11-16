import 'package:dio/dio.dart';
import 'package:flutter_built_value_dio/data/dio_call_executer.dart';
import 'package:flutter_built_value_dio/model/built_post.dart';
import 'package:built_collection/built_collection.dart';

class PostApiService {
  final DioNetworkCallExecutor dioCallExecutor;

  PostApiService(this.dioCallExecutor);

  Future<BuiltList<BuiltPost>> getPosts() async {
    final response =
        await dioCallExecutor.execute<BuiltList, BuiltPost>("/posts");
    return response;
  }

  Future<BuiltPost> postPost(
    BuiltPost body,
  ) async {
    final response =
        await dioCallExecutor.execute<BuiltPost, BuiltPost>("/posts",
          options: RequestOptions(
            method: "POST",
            data:  body
          )
        );
    return response;
  }
  
}
