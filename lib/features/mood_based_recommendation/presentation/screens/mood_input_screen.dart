import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/mood_based_recommendation/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mood_bloc.dart';

class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({super.key});

  @override
  State<MoodInputScreen> createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  final TextEditingController _moodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood-based Food Suggestion')),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              const SizedBox(),
              Text(
                "How are you feeling?",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const MoodChips(),
              const SizedBox(),
              TextField(
                controller: _moodController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Describe how you feel',
                  alignLabelWithHint: true,
                ),
                onChanged:
                    (val) => context.read<MoodBloc>().add(
                      MoodDescriptionChanged(description: val),
                    ),
              ),
              const SizedBox(),
              FilledButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<MoodBloc>().add(FetchRecommendation());
                },
                child: const Text("Get Recommendation"),
              ),
              BlocConsumer<MoodBloc, MoodState>(
                listener: (context, state) {
                  if (state.navigateToResults &&
                      state.moodRecommendations.recommendations.isNotEmpty) {
                    NavigationHelper.pushPaginatedFood(
                      context,
                      extra: state.moodRecommendations.recommendations,
                    );
                    context.read<MoodBloc>().add(ResetNavigation());
                  }
                },
                builder: (context, state) {
                  if (state.showError && state.selectedMood.isEmpty) {
                    return Text(
                      "⚠️ Please select a mood",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                  const SizedBox(height: 16);
                  if (state.isLoading) {
                    return const CustomCircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
