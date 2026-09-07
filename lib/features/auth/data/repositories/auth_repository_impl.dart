import 'package:safaricom_test/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';
import 'package:safaricom_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

  @override
  Future<AuthSession> login({required String pin}) {
    return _remote.login(pin: pin);
  }
}
