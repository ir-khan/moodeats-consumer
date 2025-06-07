import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/food/domain/entities/paginated_food.dart';
import 'package:consumer/features/food/domain/repositories/food_repository.dart';

class GetAllFoodsUseCase
    implements UseCase<DataState<PaginatedFoodEntity>, GetAllFoodsParams> {
  final FoodRepository _foodRepository;

  const GetAllFoodsUseCase(this._foodRepository);

  @override
  Future<DataState<PaginatedFoodEntity>> call(GetAllFoodsParams params) async {
    return await _foodRepository.getAllFoods(
      page: params.page,
      limit: params.limit,
      search: params.search,
      category: params.category,
      cuisine: params.cuisine,
      moodTags: params.moodTags,
    );
  }
}

class GetAllFoodsParams {
  final int page;
  final int limit;
  final String? search;
  final String? category;
  final String? cuisine;
  final List<String>? moodTags;

  GetAllFoodsParams({
    this.page = 1,
    this.limit = 10,
    this.search,
    this.category,
    this.cuisine,
    this.moodTags,
  });
}
