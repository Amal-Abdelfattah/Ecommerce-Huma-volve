import 'package:ecommerce_app_huma_volve/features/home/data/model/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts(int? categoryId);
}
