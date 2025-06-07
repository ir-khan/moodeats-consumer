import 'package:cached_network_image/cached_network_image.dart';
import 'package:consumer/features/food/domain/entities/food.dart';
import 'package:consumer/features/food/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatelessWidget {
  final FoodEntity food;

  const FoodDetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          food.name,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: food.images[0],
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  food.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Rs: ${food.price}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              food.description,
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  food.tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 16),
            LabelValueText(label: 'Restaurant', value: food.restaurant.name),
            const SizedBox(height: 8),
            LabelValueText(
              label: 'Address',
              value:
                  '${food.restaurant.addresses[0].street}, ${food.restaurant.addresses[0].city}, ${food.restaurant.addresses[0].state}, ${food.restaurant.addresses[0].country}',
            ),
            const SizedBox(height: 16),
            LabelValueText(label: 'Phone', value: food.restaurant.phone),
            const SizedBox(height: 16),
            LabelValueText(
              label: 'Open',
              value: food.restaurant.isOpen ? 'Yes' : 'No',
            ),
          ],
        ),
      ),
    );
  }
}
