import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';

import '../network/dio_client.dart';
import '../../features/home/domain/entites/home_category_entity.dart';
import '../../features/home/domain/entites/home_category_product.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  Stream<Uri> get uriLinkStream => _appLinks.uriLinkStream;

  Future<Uri?> getInitialLink() => _appLinks.getInitialLink();

  Future<HomeProductEntity?> getProductFromLink(Uri uri) async {
    if (uri.scheme != 'humavolve' || uri.host != 'product') return null;
    final idValue = uri.pathSegments.isNotEmpty
        ? uri.pathSegments.last
        : uri.queryParameters['id'];
    final id = int.tryParse(idValue ?? '');
    if (id == null || id <= 0) return null;

    try {
      final response = await DioClient.dio.get('products/$id');
      final data = response.data;
      if (data is! Map<String, dynamic>) return null;
      final categoryData = data['category'];
      final category = categoryData is Map<String, dynamic>
          ? HomeCategoryEntity(
              id: categoryData['id'] ?? 0,
              name: categoryData['name'] ?? '',
              slug: categoryData['slug'] ?? '',
              image: categoryData['image'] ?? '',
            )
          : const HomeCategoryEntity();
      final rawImages = data['images'];
      final images = rawImages is List
          ? rawImages.map((image) => image.toString()).toList()
          : <String>[];
      return HomeProductEntity(
        id: data['id'] ?? id,
        title: data['title'] ?? '',
        slug: data['slug'] ?? '',
        price: (data['price'] as num?)?.toInt() ?? 0,
        description: data['description'] ?? '',
        category: category,
        images: images,
        creationAt: data['creationAt'] ?? '',
        updatedAt: data['updatedAt'] ?? '',
      );
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
