import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/features/cart/screens/cart_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_dataSource.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_dataSource_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repo/home_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_reop.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/home_screen.dart';
import 'package:ecommerce_app_huma_volve/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late final HomeRemoteDatasource homeRemoteDataSource;
  late final HomeRepo homeRepository;
  late final GetCategoriesUseCase getCategoriesUseCase;
  late final GetProductsUseCase getProductsUseCase;
  late final HomeCubit homeCubit;

  @override
  void initState() {
    homeRemoteDataSource = HomeRemoteDatasourceImp(DioClient());
    homeRepository = HomeRepoImp(homeRemoteDataSource);
    getCategoriesUseCase = GetCategoriesUseCase(homeRepository);
    getProductsUseCase = GetProductsUseCase(homeRepository);
    homeCubit = HomeCubit(
      getProductsUseCase: getProductsUseCase,
      getCategoriesUseCase: getCategoriesUseCase,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      BlocProvider(
        create: (BuildContext context) => homeCubit,
        child: const HomeScreen(),
      ),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primary,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 32),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart_outlined, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart, size: 32),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person_outline, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person, size: 32),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
