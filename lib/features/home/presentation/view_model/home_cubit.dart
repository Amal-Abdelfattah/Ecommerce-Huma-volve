import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_product.dart'; // NEW
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  static const int _pageSize = 10;
  final List<HomeProductEntity> _products = [];
  int? _currentCategoryId;
  int _offset = 0;
  int _requestId = 0; 
  bool _isFetching = false;
  bool _hasReachedMax = false;

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

   
    await _loadFirstPage(categoryId); 
  }

  void getProductsByCategoryId(int id) async {
    emit(ProductLoading());

   
    await _loadFirstPage(id); 
  }


  Future<void> _loadFirstPage(int? categoryId) async {
    _requestId++;
    final requestId = _requestId;
    _currentCategoryId = categoryId;
    _offset = 0;
    _hasReachedMax = false;
    _isFetching = true;
    _products.clear();

    final result = await getProductsUseCase.invoke(
      categoryId,
      offset: 0,
      limit: _pageSize,
    );
    if (requestId != _requestId) return; 
    _isFetching = false;

    result.fold(
      (failure) {
        emit(ProductFailure(failure.failureMessage));
      },
      (products) {
        _products.addAll(products);
        _offset = products.length;
        _hasReachedMax = products.length < _pageSize;
        emit(
          ProductSuccess(List.of(_products), hasReachedMax: _hasReachedMax),
        );
      },
    );
  }


  Future<void> loadMoreProducts() async {
    if (_isFetching || _hasReachedMax || _currentCategoryId == null) return;
    if (state is! ProductSuccess) return;

    _isFetching = true;
    final requestId = _requestId;
    emit(ProductSuccess(List.of(_products), isLoadingMore: true));

    final result = await getProductsUseCase.invoke(
      _currentCategoryId,
      offset: _offset,
      limit: _pageSize,
    );
    if (requestId != _requestId) return; 
    _isFetching = false;

    result.fold(
      (failure) {
   
        emit(ProductSuccess(List.of(_products)));
      },
      (newProducts) {
      
        final fresh = newProducts
            .where((p) => !_products.any((old) => old.id == p.id))
            .toList();
        _products.addAll(fresh);
        _offset += newProducts.length;
        _hasReachedMax = newProducts.length < _pageSize || fresh.isEmpty;
        emit(
          ProductSuccess(List.of(_products), hasReachedMax: _hasReachedMax),
        );
      },
    );
  }
}