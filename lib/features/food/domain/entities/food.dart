import 'package:consumer/features/food/domain/entities/category.dart';
import 'package:consumer/features/food/domain/entities/cuisine.dart';
import 'package:consumer/features/food/domain/entities/restaurant.dart';
import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final double? discount;
  final bool isAvailable;
  final List<String> tags;
  final List<String> moodTags;
  final CategoryEntity category;
  final CuisineEntity cuisine;
  final RestaurantEntity restaurant;
  final double? rating;
  final List<String>? reviews;

  const FoodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.discount,
    required this.isAvailable,
    required this.tags,
    required this.moodTags,
    required this.category,
    required this.cuisine,
    required this.restaurant,
    this.rating,
    this.reviews,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    images,
    price,
    discount,
    isAvailable,
    tags,
    moodTags,
    category,
    cuisine,
    restaurant,
    rating,
    reviews,
  ];
}
