import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_product.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<HomeCategoryEntity> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends HomeState {
  final String errorMessage;

  CategoryFailure(this.errorMessage);
}

class ProductLoading extends HomeState {}

class ProductSuccess extends HomeState {
  final List<HomeProductEntity> products;
  final bool hasReachedMax; 
  final bool isLoadingMore; 

  ProductSuccess(
    this.products, {
    this.hasReachedMax = false, 
    this.isLoadingMore = false, 
  });
}

class ProductFailure extends HomeState {
  final String errorMessage;

  ProductFailure(this.errorMessage);
}