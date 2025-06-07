part of 'food_bloc.dart';

sealed class FoodState extends Equatable {
  const FoodState();
  @override
  List<Object?> get props => [];
}

final class FoodInitial extends FoodState {}

final class FoodLoading extends FoodState {}

final class FoodError extends FoodState {
  final String message;
  const FoodError(this.message);

  @override
  List<Object?> get props => [message];
}

final class FoodListLoaded extends FoodState {
  final PaginatedFoodEntity paginatedFood;
  const FoodListLoaded(this.paginatedFood);

  @override
  List<Object?> get props => [paginatedFood];
}
