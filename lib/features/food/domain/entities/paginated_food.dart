import 'package:consumer/features/food/domain/entities/food.dart';
import 'package:equatable/equatable.dart';

class PaginatedFoodEntity extends Equatable {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final List<FoodEntity> foods;

  const PaginatedFoodEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.foods,
  });

  @override
  List<Object?> get props => [total, page, limit, totalPages, foods];

  @override
  String toString() {
    return 'PaginatedFoodEntity(total: $total, page: $page, limit: $limit, totalPages: $totalPages, foods: ${foods.length})';
  }
}
