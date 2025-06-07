// import 'package:consumer/features/mood_based_recommendation/presentation/bloc/mood_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MoodFoodSuggestionWidget extends StatelessWidget {
//   const MoodFoodSuggestionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MoodBloc, MoodState>(
//       builder: (context, state) {
//         if (state is MoodLoading) {
//           return const CustomCircularProgressIndicator();
//         } else if (state is MoodLoaded) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Mood-based Suggestions",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: state.suggestions.length,
//                   itemBuilder: (context, index) {
//                     final food = state.suggestions[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Center(child: Text(food)),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else if (state is MoodError) {
//           return Text("Error: ${state.message}");
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
