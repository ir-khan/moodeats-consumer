import 'dart:io';
import 'package:consumer/core/network/api_client.dart';
import 'package:consumer/core/network/api_endpoints.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:dio/dio.dart';

abstract interface class FoodRemoteDataSource {
  Future<Response> getAllFoods({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? cuisine,
    List<String>? moodTags,
  });
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  final ApiClient _apiClient;

  FoodRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Response> getAllFoods({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? cuisine,
    List<String>? moodTags,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }

      if (category != null && category.isNotEmpty) {
        queryParameters['category'] = category;
      }

      if (cuisine != null && cuisine.isNotEmpty) {
        queryParameters['cuisine'] = cuisine;
      }

      if (moodTags != null && moodTags.isNotEmpty) {
        for (var tag in moodTags) {
          queryParameters['moodTags'] =
              queryParameters.containsKey('moodTags')
                  ? [...queryParameters['moodTags'], tag]
                  : [tag];
        }
      }
      final response = await _apiClient.dio.get(
        ApiEndpoints.foods,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Error fetching foods',
      );
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (_) {
      throw InternalException('Unexpected error fetching food list');
    }
  }
}
