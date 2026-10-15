import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_reop.dart';

class GetCategoriesUseCase {
  final HomeRepo homeRepo;
  GetCategoriesUseCase(this.homeRepo);

  Future<Either<Failure, List<HomeCategoryEntity>>> invoke() =>
      homeRepo.getCategories();
}
