import 'package:consumer/core/network/api_endpoints.dart';
import 'package:consumer/core/network/api_interceptor.dart';
import 'package:consumer/core/session_manager.dart';
import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;
  final SessionManager _sessionManager;

  ApiClient(this._sessionManager) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.serverURL,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(ApiInterceptor(dio, _sessionManager));
  }
}
