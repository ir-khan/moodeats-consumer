import 'package:consumer/core/utils/data_state.dart';
import 'package:consumer/features/food/domain/entities/paginated_food.dart';
import 'package:consumer/features/food/domain/usecases/get_all_foods.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetAllFoodsUseCase _getAllFoodsUseCase;

  FoodBloc({required GetAllFoodsUseCase getAllFoodsUseCase})
    : _getAllFoodsUseCase = getAllFoodsUseCase,

      super(FoodInitial()) {
    on<GetAllFoodsEvent>(_onGetAllFoods);
  }

  Future<void> _onGetAllFoods(
    GetAllFoodsEvent event,
    Emitter<FoodState> emit,
  ) async {
    emit(FoodLoading());
    final result = await _getAllFoodsUseCase(
      GetAllFoodsParams(
        page: event.page,
        limit: event.limit,
        search: event.search,
        category: event.category,
        cuisine: event.cuisine,
        moodTags: event.moodTags,
      ),
    );
    emit(
      result is DataSuccess<PaginatedFoodEntity>
          ? FoodListLoaded(result.extractedData!)
          : FoodError(result.error),
    );
  }
}
