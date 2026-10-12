import 'package:ecommerce_app_huma_volve/features/home/data/model/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoryLoading extends HomeState {}

class CategorySuccess extends HomeState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends HomeState {
  final String errorMessage;

  CategoryFailure(this.errorMessage);
}

class ProductLoading extends HomeState {}

class ProductSuccess extends HomeState {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends HomeState {
  final String errorMessage;

  ProductFailure(this.errorMessage);
}
