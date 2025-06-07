part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent extends Equatable {}

final class OnboardingPageChangedEvent extends OnboardingEvent {
  final int page;
  OnboardingPageChangedEvent({required this.page});

  @override
  List<Object> get props => [page];
}

final class OnboardingSkipedOrNavigatedEvent extends OnboardingEvent {
  OnboardingSkipedOrNavigatedEvent();
  @override
  List<Object> get props => [];
}
