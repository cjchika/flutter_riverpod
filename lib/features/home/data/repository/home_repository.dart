import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_api/core/network/dio_exceptions.dart';
import 'package:riverpod_api/features/home/data/api/home_api.dart';
import 'package:riverpod_api/features/home/data/models/joke_model.dart';

abstract class IHomeRepository {
  Future<JokeModel> fetchJoke();
}

class HomeRepository extends IHomeRepository {
  final HomeApi _homeApi;

  HomeRepository(this._homeApi);

  @override
  Future<JokeModel> fetchJoke() async {
    try {
      final res = await _homeApi.fetchJokesApiRequest();
      final jokeModel = JokeModel.fromJson(res);
      return jokeModel;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      log(errorMessage.toString());
      rethrow;
    }
  }
}
