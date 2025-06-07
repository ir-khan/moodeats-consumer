import 'package:consumer/features/food/domain/entities/paginated_food.dart';

import 'food_model.dart';

class PaginatedFoodResponse extends PaginatedFoodEntity {
  const PaginatedFoodResponse({
    required super.total,
    required super.page,
    required super.limit,
    required super.totalPages,
    required super.foods,
  });

  factory PaginatedFoodResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> foodsJson = json['foods'] ?? [];
    return PaginatedFoodResponse(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
      foods: foodsJson.map((e) => FoodModel.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'PaginatedFoodResponse(total: $total, page: $page, limit: $limit, '
        'totalPages: $totalPages, foods: ${foods.length})';
  }
}
