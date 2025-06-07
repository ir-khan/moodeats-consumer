import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountDetailsShimmerWidget extends StatelessWidget {
  const AccountDetailsShimmerWidget({super.key});

  Widget _shimmerBox({double height = 20, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
      children: [
        const SizedBox(),
        _shimmerSectionCard(title: 'Public Info'),
        _shimmerSectionCard(title: 'Private Details'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _shimmerBox(height: 50),
        ),
      ],
    );
  }

  Widget _shimmerSectionCard({required String title}) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerBox(height: 25, width: 100),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Column(
              spacing: 8,
              children: [_shimmerBox(height: 28), _shimmerBox(height: 28)],
            ),
          ),
        ),
      ],
    );
  }
}
