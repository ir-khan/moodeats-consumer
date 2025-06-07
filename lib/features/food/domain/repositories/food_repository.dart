import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/food/domain/entities/paginated_food.dart';

abstract interface class FoodRepository {
  Future<DataState<PaginatedFoodEntity>> getAllFoods({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? cuisine,
    List<String>? moodTags,
  });
}
