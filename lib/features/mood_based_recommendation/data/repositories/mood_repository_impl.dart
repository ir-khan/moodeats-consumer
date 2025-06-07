import 'package:consumer/core/network/connection_checker.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/mood_based_recommendation/data/models/mood_recommendation_model.dart';

import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_remote_data_source.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource _remoteDataSource;
  final ConnectionChecker _connectionChecker;

  MoodRepositoryImpl(this._remoteDataSource, this._connectionChecker);

  @override
  Future<DataState<MoodRecommendationModel>> getRecommendation(
    String mood,
    String description,
  ) async {
    if (!await _connectionChecker.isConnected) {
      return DataFailure(error: 'No internet connection');
    }
    try {
      final response = await _remoteDataSource.fetchMoodRecommendation(
        mood,
        description,
      );
      if (response.statusCode != 200) {
        return DataFailure(error: response.data['message']);
      }
      final responseData = DataSuccess<MoodRecommendationModel>.fromJson(
        response.data,
        'recommendationData',
        (json) => MoodRecommendationModel.fromJson(json),
      );

      return responseData;
    } on AppException catch (e) {
      return DataFailure(error: e.message);
    }
  }
}
