import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.success,
    required this.message,
    required this.session,
  });

  final bool success;
  final String message;
  final AuthSession? session;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final userJson = data?['user'] as Map<String, dynamic>?;

    return LoginResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      session: userJson == null
          ? null
          : AuthSession(
              user: AuthUser(
                id: userJson['id'] as String? ?? '',
                name: userJson['name'] as String? ?? '',
                phoneNumber: userJson['phoneNumber'] as String? ?? '',
                email: userJson['email'] as String? ?? '',
                balance: (userJson['balance'] as num?)?.toDouble() ?? 0,
                currency: userJson['currency'] as String? ?? 'ETB',
              ),
              token: data?['token'] as String? ?? '',
              expiresIn: data?['expiresIn'] as int? ?? 0,
            ),
    );
  }
}
