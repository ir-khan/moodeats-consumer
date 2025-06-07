import 'package:consumer/core/network/connection_checker.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/food/data/datasources/food_remote_data_source.dart';
import 'package:consumer/features/food/data/models/paginated_food_response.dart';
import 'package:consumer/features/food/domain/repositories/food_repository.dart';
import 'package:flutter/material.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource _remoteDataSource;
  final ConnectionChecker _connectionChecker;

  FoodRepositoryImpl(this._remoteDataSource, this._connectionChecker);

  @override
  Future<DataState<PaginatedFoodResponse>> getAllFoods({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? cuisine,
    List<String>? moodTags,
  }) async {
    if (!await _connectionChecker.isConnected) {
      return DataFailure(error: 'No internet connection');
    }
    try {
      final response = await _remoteDataSource.getAllFoods(
        page: page,
        limit: limit,
        search: search,
        category: category,
        cuisine: cuisine,
        moodTags: moodTags,
      );

      if (response.statusCode == 200) {
        debugPrint('Response data: ${response.data['data']}');
        return DataSuccess(
          data: {},
          statusCode: 200,
          message: 'Foods fetched successfully',
          success: true,
          extractedData: PaginatedFoodResponse.fromJson(response.data['data']),
        );
      } else {
        return DataFailure(error: response.data['message']);
      }
    } on AppException catch (e) {
      return DataFailure(error: e.message);
    } catch (e, stackTrace) {
      debugPrint('Error during getAllFoods: $e');
      debugPrintStack(stackTrace: stackTrace);
      return DataFailure(error: 'Unexpected error occurred');
    }
  }
}
