import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:consumer/features/onboarding/data/sources/onboarding_data_source.dart';
import 'package:consumer/features/onboarding/presentation/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSkipedOrNavigatedState) {
            NavigationHelper.goToLogin(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingData.pages.length,
                  onPageChanged: (int page) {
                    context.read<OnboardingBloc>().add(
                      OnboardingPageChangedEvent(page: page),
                    );
                  },
                  itemBuilder: (context, index) {
                    return OnboardingWidget(
                      onboardingModel: OnboardingData.pages[index],
                    );
                  },
                ),
                Align(
                  alignment: Alignment(0, 0.9),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: OnboardingData.pages.length,
                    effect: ScrollingDotsEffect(
                      activeStrokeWidth: 0,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      dotColor: Theme.of(context).colorScheme.tertiary,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.9, -0.95),
                  child: OutlinedButton(
                    onPressed:
                        () => context.read<OnboardingBloc>().add(
                          OnboardingSkipedOrNavigatedEvent(),
                        ),
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0),
                      ),
                    ),
                    child: Text('Skip'),
                  ),
                ),
                if (_pageController.hasClients &&
                    _pageController.page?.round() == 2)
                  Align(
                    alignment: Alignment(0.9, 0.95),
                    child: FilledButton(
                      onPressed:
                          () => context.read<OnboardingBloc>().add(
                            OnboardingSkipedOrNavigatedEvent(),
                          ),
                      child: Text('Next'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
