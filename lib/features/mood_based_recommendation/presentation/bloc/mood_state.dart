part of 'mood_bloc.dart';

class MoodState extends Equatable {
  final String selectedMood;
  final String description;
  final MoodRecommendationEntity moodRecommendations;
  final bool isLoading;
  final bool showError;
  final bool navigateToResults;

  const MoodState({
    this.selectedMood = '',
    this.description = '',
    MoodRecommendationEntity? moodRecommendations,
    this.isLoading = false,
    this.showError = false,
    this.navigateToResults = false,
  }) : moodRecommendations =
           moodRecommendations ??
           const MoodRecommendationEntity(recommendations: []);

  @override
  List<Object?> get props => [
    selectedMood,
    description,
    moodRecommendations,
    isLoading,
    showError,
    navigateToResults,
  ];

  MoodState copyWith({
    String? selectedMood,
    String? description,
    MoodRecommendationEntity? moodRecommendations,
    bool? isLoading,
    bool? showError,
    bool? navigateToResults,
  }) {
    return MoodState(
      selectedMood: selectedMood ?? this.selectedMood,
      description: description ?? this.description,
      moodRecommendations: moodRecommendations ?? this.moodRecommendations,
      isLoading: isLoading ?? this.isLoading,
      showError: showError ?? this.showError,
      navigateToResults: navigateToResults ?? this.navigateToResults,
    );
  }
}
