import 'dart:io';

import 'package:consumer/core/network/api_client.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:dio/dio.dart';

abstract class MoodRemoteDataSource {
  Future<Response> fetchMoodRecommendation(String mood, String description);
}

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final ApiClient _apiClient;

  MoodRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Response> fetchMoodRecommendation(
    String mood,
    String description,
  ) async {
    try {
      Response response = await _apiClient.dio.post(
        '/mood/recommend',
        data: {'mood': mood, 'description': description},
      );

      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error during recommendation.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException(
        "Unexpected error occurred during recommendation.",
      );
    }
  }
}
