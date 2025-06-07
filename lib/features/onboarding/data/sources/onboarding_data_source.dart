import 'package:consumer/core/constants/app_assets.dart';
import 'package:consumer/features/onboarding/data/models/onboarding_model.dart';

class OnboardingData {
  static final List<OnboardingModel> pages = [
    OnboardingModel(
      image: AppAssets.onboarding1,
      title: "Discover Your Cravings",
      description:
          "Tell us how you're feeling, and we'll suggest the perfect meal for your mood!",
    ),
    OnboardingModel(
      image: AppAssets.onboarding2,
      title: "Smart AI Recommendations",
      description:
          "Let our AI-powered engine analyze your taste preferences and suggest the best food for you.",
    ),
    OnboardingModel(
      image: AppAssets.onboarding3,
      title: "Hassle-Free Ordering",
      description:
          "Order your favorite food with just a tap and get it delivered hot and fresh!",
    ),
  ];
}