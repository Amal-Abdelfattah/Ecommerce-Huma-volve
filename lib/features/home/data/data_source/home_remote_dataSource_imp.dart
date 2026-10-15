import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_dataSource.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_model.dart';

class HomeRemoteDatasourceImp implements HomeRemoteDatasource {
  final DioClient dioClient;
  HomeRemoteDatasourceImp(this.dioClient);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await DioClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categories;
  }

  @override
  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await DioClient.dio.get(
      "${ApiEndpoints.productsEndpoint}/$categoryId/${ApiEndpoints.categoriesEndpoint}",
    );
    final List jsonData = response.data;
    final List<ProductModel> products = jsonData
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return products;
  }
}
