import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoryLoading());

    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoryFailure(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategorySuccess(categories));
      },
    );

    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductFailure(failure.failureMessage));
      },
      (products) {
        emit(ProductSuccess(products));
      },
    );
  }

  void getProductsByCategoryId(int id) async {
    emit(ProductLoading());

    final products = await getProductsUseCase.invoke(id);
    products.fold(
      (failure) {
        emit(ProductFailure(failure.failureMessage));
      },
      (products) {
        emit(ProductSuccess(products));
      },
    );
  }
}
