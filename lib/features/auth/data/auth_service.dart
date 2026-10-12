import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';

class Authservice {
  Future<String> Login({
    required String email,
    required String password,
  }) async {
    final response = await DioClient.dio.post(
      ApiEndpoints.authLoginEndpoint,
      data: {"email": email, "password": password},
    );
    return response.data['access_token'];
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await DioClient.dio.post(
      ApiEndpoints.authRegisterEndpoint ,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "role": "customer",
        "avatar": "https://api.lorem.space/image/face?w=640&h=480&r=867",
      },
    );
  }
}
