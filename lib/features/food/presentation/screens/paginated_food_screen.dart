import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/services/services.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/food/domain/entities/food.dart';
import 'package:consumer/features/food/presentation/bloc/food_bloc.dart';
import 'package:consumer/features/food/presentation/widgets/food_card.dart';
import 'package:consumer/features/food/presentation/widgets/food_shimmer_grid.dart';
import 'package:consumer/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginatedFoodScreen extends StatefulWidget {
  final List<String> moodTags;

  const PaginatedFoodScreen({super.key, required this.moodTags});

  @override
  State<PaginatedFoodScreen> createState() => _PaginatedFoodScreenState();
}

class _PaginatedFoodScreenState extends State<PaginatedFoodScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _limit = 10;
  bool _isLoadingMore = false;
  List<FoodEntity> _foods = [];
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _loadFoods();

    _scrollController.addListener(() {
      final pixels = _scrollController.position.pixels;
      final maxExtent = _scrollController.position.maxScrollExtent;

      print(
        'pixels: $pixels, maxExtent: $maxExtent, '
        '_isLoadingMore: $_isLoadingMore, '
        '_currentPage: $_currentPage, _totalPages: $_totalPages',
      );

      final nearBottom = pixels >= maxExtent - 300;
      final canLoadMore = !_isLoadingMore && _currentPage <= _totalPages;

      print('nearBottom: $nearBottom, canLoadMore: $canLoadMore');

      if (nearBottom && canLoadMore) {
        _loadMoreFoods();
      }
    });
  }

  void _loadFoods() {
    _isLoadingMore = true;
    context.read<FoodBloc>().add(
      GetAllFoodsEvent(
        page: _currentPage,
        limit: _limit,
        moodTags: widget.moodTags,
      ),
    );
  }

  void _loadMoreFoods() {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    context.read<FoodBloc>().add(
      GetAllFoodsEvent(
        page: _currentPage,
        limit: _limit,
        moodTags: widget.moodTags,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended Foods',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: BlocConsumer<FoodBloc, FoodState>(
        listener: (context, state) {
          if (state is FoodListLoaded) {
            final newFoods = state.paginatedFood.foods;
            _totalPages = state.paginatedFood.totalPages;

            if (_currentPage == 1) {
              _foods = newFoods;
            } else {
              _foods.addAll(newFoods);
              _isLoadingMore = false;
            }
            _currentPage++;
            _isLoadingMore = false;
          } else if (state is FoodError) {
            serviceLocator<ToastService>().show(
              message: state.message,
              toastType: ToastType.error,
            );
            _isLoadingMore = false;
          }
        },
        builder: (context, state) {
          if (state is FoodLoading && _currentPage == 1) {
            return const FoodShimmerGrid();
          } else if (_foods.isEmpty) {
            return Center(
              child: Text("No foods found", style: theme.textTheme.bodyLarge),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              controller: _scrollController,
              itemCount: _foods.length + (_currentPage < _totalPages ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                if (index >= _foods.length) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  );
                }
                final food = _foods[index];
                return FoodCard(
                  food: food,
                  onTap:
                      () => NavigationHelper.pushFoodDetails(
                        context,
                        extra: food,
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
