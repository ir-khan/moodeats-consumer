part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();
  @override
  List<Object?> get props => [];
}

final class GetAllFoodsEvent extends FoodEvent {
  final int page;
  final int limit;
  final String? search;
  final String? category;
  final String? cuisine;
  final List<String>? moodTags;

  const GetAllFoodsEvent({
    this.page = 1,
    this.limit = 10,
    this.search,
    this.category,
    this.cuisine,
    this.moodTags,
  });

  @override
  List<Object?> get props => [
    page,
    limit,
    search,
    category,
    cuisine,
    moodTags,

  ];
}
