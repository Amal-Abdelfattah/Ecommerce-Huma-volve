import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_reop.dart';

class GetProductsUseCase {
  final HomeRepo homeRepo;
  GetProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<HomeProductEntity>>> invoke(
    int? categoryId, {
    int offset = 0,
    int limit = 10,
  }) => homeRepo.getProducts(categoryId, offset: offset, limit: limit);
}
