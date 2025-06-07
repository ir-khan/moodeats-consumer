part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState extends Equatable {}

final class OnboardingChangeState extends OnboardingState {
  final int currentPage;

  OnboardingChangeState({required this.currentPage});
  @override
  List<Object> get props => [currentPage];
}

final class OnboardingSkipedOrNavigatedState extends OnboardingState {
  @override
  List<Object?> get props => [];
}
