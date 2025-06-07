import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/mood_based_recommendation/domain/entities/mood_recommendation.dart';
import 'package:consumer/features/mood_based_recommendation/domain/usecases/get_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final GetRecommendationUseCase _getRecommendation;

  MoodBloc({required GetRecommendationUseCase getRecommendation})
    : _getRecommendation = getRecommendation,
      super(MoodState()) {
    on<MoodSelected>(_onMoodSelected);
    on<MoodDescriptionChanged>(_onMoodDescriptionChanged);
    on<ResetNavigation>(_onResetNavigation);
    on<FetchRecommendation>(_onFetchRecommendation);
  }

  void _onMoodSelected(MoodSelected event, Emitter<MoodState> emit) {
    emit(state.copyWith(selectedMood: event.mood));
  }

  void _onMoodDescriptionChanged(
    MoodDescriptionChanged event,
    Emitter<MoodState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onResetNavigation(ResetNavigation event, Emitter<MoodState> emit) {
    emit(state.copyWith(navigateToResults: false));
  }

  Future<void> _onFetchRecommendation(
    FetchRecommendation event,
    Emitter<MoodState> emit,
  ) async {
    if (state.selectedMood.isEmpty) {
      emit(state.copyWith(showError: true));
      return;
    }

    emit(state.copyWith(isLoading: true, showError: false));

    final result = await _getRecommendation(
      GetRecommendationParams(
        mood: state.selectedMood,
        description: state.description,
      ),
    );

    if (result is DataSuccess<MoodRecommendationEntity>) {
      emit(
        state.copyWith(
          moodRecommendations: result.extractedData,
          isLoading: false,
          navigateToResults: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          moodRecommendations: const MoodRecommendationEntity(
            recommendations: [],
          ),
          isLoading: false,
        ),
      );
    }
  }
}
