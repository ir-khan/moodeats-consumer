import 'package:consumer/core/network/api_endpoints.dart';
import 'package:consumer/core/session_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  final SessionManager _sessionManager;

  ApiInterceptor(this.dio, this._sessionManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _sessionManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    debugPrint("Request: ${options.uri}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response: ${response.data}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      debugPrint("Access token expired. Attempting to refresh token...");
      final newAccessToken = await _refreshToken();

      if (newAccessToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // Retry the request with the new token
        final opts = err.requestOptions;
        final clonedRequest = await dio.fetch(opts);
        return handler.resolve(clonedRequest);
      }
    }
    debugPrint("Error: ${err.message}");
    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _sessionManager.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await dio.post(
        ApiEndpoints.authRefreshToken,
        data: {"refreshToken": refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      if (newAccessToken != null) {
        await _sessionManager.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        return newAccessToken;
      }
    } catch (e) {
      debugPrint("Failed to refresh token: $e");
      return null;
    }
    return null;
  }
}
