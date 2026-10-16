import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_dataSource.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/product_model.dart';
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
      return Right(categories.map(_categoryToEntity).toList());
    } catch (e) {
      return Left(Failure(failureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId, {
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final products = await homeRemoteDatasource.getProducts(
        categoryId,
        offset: offset,
        limit: limit,
      );
      return Right(products.map(_productToEntity).toList());
    } catch (e) {
      return Left(Failure(failureMessage: e.toString()));
    }
  }

  HomeCategoryEntity _categoryToEntity(CategoryModel m) => HomeCategoryEntity(
    id: m.id ?? 0,
    name: m.name ?? '',
    slug: m.slug ?? '',
    image: m.image ?? '',
    creationAt: m.creationAt ?? '',
    updatedAt: m.updatedAt ?? '',
  );

  HomeProductEntity _productToEntity(ProductModel m) => HomeProductEntity(
    id: m.id ?? 0,
    title: m.title ?? '',
    slug: m.slug ?? '',
    price: m.price ?? 0,
    description: m.description ?? '',
    category: HomeCategoryEntity(
      id: m.category?.id ?? 0,
      name: m.category?.name ?? '',
      slug: m.category?.slug ?? '',
      image: m.category?.image ?? '',
      creationAt: m.category?.creationAt ?? '',
      updatedAt: m.category?.updatedAt ?? '',
    ),
    images: m.images ?? const [],
    creationAt: m.creationAt ?? '',
    updatedAt: m.updatedAt ?? '',
  );
}
