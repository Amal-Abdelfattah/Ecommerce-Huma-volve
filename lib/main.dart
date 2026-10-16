import 'dart:async';

import 'package:flutter/material.dart';

import 'core/deep_linking/deep_link_service.dart';
import 'core/theme.dart';
import 'features/details/screens/product_details_screen.dart';
import 'features/splash/screens/splash_screen.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DeepLinkService _deepLinkService = DeepLinkService();
  StreamSubscription<Uri>? _linkSubscription;
  bool _handlingInitialLink = false;

  @override
  void initState() {
    super.initState();
    _listenForLinks();
  }

  Future<void> _listenForLinks() async {
    _linkSubscription = _deepLinkService.uriLinkStream.listen(
      _openProductFromUri,
    );
    final initialUri = await _deepLinkService.getInitialLink();
    if (initialUri != null) {
      _handlingInitialLink = true;
      await Future<void>.delayed(const Duration(milliseconds: 2300));
      await _openProductFromUri(initialUri);
      _handlingInitialLink = false;
    }
  }

  Future<void> _openProductFromUri(Uri uri) async {
    if (_handlingInitialLink && uri.scheme != 'humavolve') return;
    final product = await _deepLinkService.getProductFromLink(uri);
    if (product == null) return;
    final navigator = appNavigatorKey.currentState;
    if (navigator == null) return;
    navigator.push(
      MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
    );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
