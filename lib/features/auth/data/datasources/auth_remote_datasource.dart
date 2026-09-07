import 'package:dio/dio.dart';
import 'package:safaricom_test/core/network/api_constants.dart';
import 'package:safaricom_test/core/network/api_exception.dart';
import 'package:safaricom_test/core/network/dio_provider.dart';
import 'package:safaricom_test/features/auth/data/models/login_response_model.dart';
import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSession> login({required String pin}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiConstants.login,
        data: {'pin': pin},
      );
      final body = response.data;
      if (body == null) {
        throw const ApiException('Empty response from server.');
      }

      final parsed = LoginResponseModel.fromJson(body);
      final session = parsed.session;
      if (!parsed.success || session == null) {
        throw ApiException(parsed.message);
      }
      return session;
    } on DioException catch (error) {
      throw mapDioError(error);
    }
  }
}
