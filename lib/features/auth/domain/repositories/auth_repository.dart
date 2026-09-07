import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String pin});
}
