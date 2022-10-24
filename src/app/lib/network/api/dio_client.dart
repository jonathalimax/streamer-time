import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl =
      'https://us-central1-streamertime-app.cloudfunctions.net/api';

  Future registerDeviceToken(String userId, String deviceToken) async {
    try {
      await _dio.post(
        _baseUrl + '/user/$userId/token',
        data: {'deviceToken': deviceToken},
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  Future updateTopics(String userId) async {
    try {
      await _dio.post(_baseUrl + '/user/$userId/topics');
    } on DioError catch (e) {
      print(e);
    }
  }

  Future unsubscribeFromTopics(String userId) async {
    try {
      await _dio.delete(_baseUrl + '/user/$userId/topics');
    } on DioError catch (e) {
      print(e);
    }
  }
}
