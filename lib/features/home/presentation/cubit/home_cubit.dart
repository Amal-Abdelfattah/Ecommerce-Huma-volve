import 'package:ecommerce_app_huma_volve/features/home/data/service/home_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitial());

  void loadingHomedata() async {
    emit(CategoryLoading());
    try {
      final categories = await homeService.getCategories();
      emit(CategorySuccess(categories));
      final products = await homeService.getProducts(categories[0].id);
      emit(ProductSuccess(products));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
}
