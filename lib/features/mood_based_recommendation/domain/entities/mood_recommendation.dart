import 'package:equatable/equatable.dart';

class MoodRecommendationEntity extends Equatable {
  final List<String> recommendations;

  const MoodRecommendationEntity({required this.recommendations});

  @override
  List<Object?> get props => [recommendations];
}
