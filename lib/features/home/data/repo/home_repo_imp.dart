import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_dataSource.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_product.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_reop.dart';

class HomeRepoImp implements HomeRepo {
  final HomeRemoteDatasource homeRemoteDatasource;
  HomeRepoImp(this.homeRemoteDatasource);
  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDatasource.getCategories();
      return Right(categories as List<HomeCategoryEntity>);
    } catch (e) {
      return Left(Failure(failureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId,
  ) async {
    try {
      final products = await homeRemoteDatasource.getProducts(categoryId);
      return Right(products as List<HomeProductEntity>);
    } catch (e) {
      return Left(Failure(failureMessage: e.toString()));
    }
  }
}
