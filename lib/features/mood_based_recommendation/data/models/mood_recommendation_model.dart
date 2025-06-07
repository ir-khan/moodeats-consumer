import 'package:consumer/features/mood_based_recommendation/domain/entities/mood_recommendation.dart';

class MoodRecommendationModel extends MoodRecommendationEntity {
  const MoodRecommendationModel({required super.recommendations});

  factory MoodRecommendationModel.fromJson(Map<String, dynamic> json) {
    return MoodRecommendationModel(
      recommendations: List<String>.from(json['recommendations']),
    );
  }
}
