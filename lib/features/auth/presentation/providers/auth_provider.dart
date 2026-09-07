import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safaricom_test/core/network/api_exception.dart';
import 'package:safaricom_test/core/network/dio_provider.dart';
import 'package:safaricom_test/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safaricom_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';
import 'package:safaricom_test/features/auth/domain/repositories/auth_repository.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

class AuthState {
  const AuthState({
    this.isLoading = false,
    this.error,
    this.session,
  });

  final bool isLoading;
  final String? error;
  final AuthSession? session;

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthSession? session,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      session: session ?? this.session,
    );
  }
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  void clearError() {
    if (state.error == null) return;
    state = const AuthState();
  }

  Future<bool> login({required String pin}) async {
    if (pin.length != 4) {
      state = const AuthState(error: 'Enter your 4-digit M-PESA PIN.');
      return false;
    }

    state = const AuthState(isLoading: true);
    try {
      final session = await ref.read(authRepositoryProvider).login(pin: pin);
      state = AuthState(session: session);
      return true;
    } on ApiException catch (error) {
      state = AuthState(error: error.message);
      return false;
    } catch (_) {
      state = const AuthState(error: 'Something went wrong. Please try again.');
      return false;
    }
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
