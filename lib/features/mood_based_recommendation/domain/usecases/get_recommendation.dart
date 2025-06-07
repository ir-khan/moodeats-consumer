import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/mood_based_recommendation/domain/entities/mood_recommendation.dart';

import '../repositories/mood_repository.dart';

class GetRecommendationUseCase
    implements
        UseCase<DataState<MoodRecommendationEntity>, GetRecommendationParams> {
  final MoodRepository repository;
  GetRecommendationUseCase(this.repository);

  @override
  Future<DataState<MoodRecommendationEntity>> call(
    GetRecommendationParams params,
  ) {
    return repository.getRecommendation(params.mood, params.description);
  }
}

class GetRecommendationParams {
  final String mood;
  final String description;

  GetRecommendationParams({required this.mood, required this.description});
}
