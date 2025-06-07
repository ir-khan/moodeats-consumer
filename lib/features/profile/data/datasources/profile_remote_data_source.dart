import 'dart:io';

import 'package:consumer/core/network/api_client.dart';
import 'package:consumer/core/network/api_endpoints.dart';
import 'package:consumer/core/utils/app_exception.dart';
import 'package:dio/dio.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Response> getProfile();
  Future<Response> updateProfile({required String name, required String phone});
  Future<Response> updateAvatar({required File avatar});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Response> getProfile() async {
    try {
      Response response = await _apiClient.dio.get(ApiEndpoints.profile);
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error while fetching profile.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException(
        "Unexpected error occurred while fetching profile.",
      );
    }
  }

  @override
  Future<Response> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      Response response = await _apiClient.dio.put(
        ApiEndpoints.profile,
        data: {"name": name, "phone": phone},
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error while updating profile.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException(
        "Unexpected error occurred while updating profile.",
      );
    }
  }

  @override
  Future<Response> updateAvatar({required File avatar}) async {
    try {
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split("/").last,
        ),
      });

      Response response = await _apiClient.dio.patch(
        ApiEndpoints.avatarUpdate,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error while updating avatar.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException(
        "Unexpected error occurred while updating avatar.",
      );
    }
  }
}
