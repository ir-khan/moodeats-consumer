

import 'package:consumer/features/food/data/models/category_model.dart';
import 'package:consumer/features/food/data/models/cuisine_model.dart';
import 'package:consumer/features/food/data/models/restaurant_model.dart';
import 'package:consumer/features/food/domain/entities/food.dart';

class FoodModel extends FoodEntity {
  const FoodModel({
    required super.id,
    required super.name,
    required super.description,
    required super.images,
    required super.price,
    super.discount,
    required super.isAvailable,
    required super.tags,
    required super.moodTags,
    required CategoryModel super.category,
    required CuisineModel super.cuisine,
    required RestaurantModel super.restaurant,
    super.rating,
    super.reviews,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
      tags: List<String>.from(json['tags'] ?? []),
      moodTags: List<String>.from(json['moodTags'] ?? []),
      category:
          json['category'] is String
              ? CategoryModel(
                id: json['category'],
                name: '',
                value: '',
                image: '',
              )
              : CategoryModel.fromJson(json['category']),
      cuisine:
          json['cuisine'] is String
              ? CuisineModel(
                id: json['cuisine'],
                name: '',
                value: '',
                image: '',
              )
              : CuisineModel.fromJson(json['cuisine']),
      restaurant:
          json['restaurant'] is String
              ? RestaurantModel.empty(json['restaurant'])
              : RestaurantModel.fromJson(json['restaurant']),
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: List<String>.from(json['reviews'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'images': images,
    'price': price,
    'discount': discount,
    'isAvailable': isAvailable,
    'tags': tags,
    'moodTags': moodTags,
    'category': category.id,
    'cuisine': cuisine.id,
    'restaurant': restaurant.id,
    'rating': rating,
    'reviews': reviews,
  };

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    double? price,
    double? discount,
    bool? isAvailable,
    List<String>? tags,
    List<String>? moodTags,
    CategoryModel? category,
    CuisineModel? cuisine,
    RestaurantModel? restaurant,
    double? rating,
    List<String>? reviews,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      isAvailable: isAvailable ?? this.isAvailable,
      tags: tags ?? this.tags,
      moodTags: moodTags ?? this.moodTags,
      category: category ?? (this.category as CategoryModel).copyWith(),
      cuisine: cuisine ?? (this.cuisine as CuisineModel).copyWith(),
      restaurant: restaurant ?? (this.restaurant as RestaurantModel).copyWith(),
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, price: $price, category: $category, cuisine: $cuisine, restaurant: $restaurant)';
  }
}
