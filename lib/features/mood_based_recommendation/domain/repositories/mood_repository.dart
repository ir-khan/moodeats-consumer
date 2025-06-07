import 'package:consumer/core/utils/data_state.dart';
import 'package:consumer/features/mood_based_recommendation/domain/entities/mood_recommendation.dart';

abstract class MoodRepository {
  Future<DataState<MoodRecommendationEntity>> getRecommendation(String mood, String description);
}
