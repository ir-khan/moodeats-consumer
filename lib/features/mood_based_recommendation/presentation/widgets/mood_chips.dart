import 'package:consumer/features/mood_based_recommendation/presentation/bloc/mood_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodChips extends StatelessWidget {
  const MoodChips({super.key});

  @override
  Widget build(BuildContext context) {
    final moods = [
      'Happy',
      'Sad',
      'Anxious',
      'Tired',
      'Excited',
      'Angry',
      'Bored',
      'Relaxed',
      'Lonely',
      'Romantic',
      'Sick',
      'Energetic',
      'Stressed',
      'Nostalgic',
      'Motivated',
      'Confused',
      'Grateful',
      'Frustrated',
      'Calm',
      'Overwhelmed',
    ];

    return Wrap(
      spacing: 8,
      children:
          moods.map((mood) {
            return BlocBuilder<MoodBloc, MoodState>(
              builder: (context, state) {
                final isSelected = state.selectedMood == mood;
                return ChoiceChip(
                  label: Text(
                    mood,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).disabledColor,
                    ),
                  ),
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected:
                      (_) => context.read<MoodBloc>().add(
                        MoodSelected(mood: mood),
                      ),
                );
              },
            );
          }).toList(),
    );
  }
}
