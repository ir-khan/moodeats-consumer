part of 'mood_bloc.dart';

sealed class MoodEvent extends Equatable {
  const MoodEvent();
}

final class MoodSelected extends MoodEvent {
  final String mood;
  const MoodSelected({required this.mood});

  @override
  List<Object?> get props => [mood];
}

final class MoodDescriptionChanged extends MoodEvent {
  final String description;
  const MoodDescriptionChanged({required this.description});

  @override
  List<Object?> get props => [];
}

final class FetchRecommendation extends MoodEvent {
  @override
  List<Object?> get props => [];
}

final class ResetNavigation extends MoodEvent {
  @override
  List<Object?> get props => [];
}
