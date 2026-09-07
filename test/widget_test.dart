import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:safaricom_test/app/app.dart';
import 'package:safaricom_test/core/network/api_exception.dart';
import 'package:safaricom_test/features/auth/domain/entities/auth_session.dart';
import 'package:safaricom_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:safaricom_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:safaricom_test/features/auth/presentation/screens/auth_screen.dart';
import 'package:safaricom_test/features/home/presentation/screens/home_screen.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_scan_fab.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<AuthSession> login({required String pin}) async {
    if (pin != '1111') {
      throw const ApiException('User not found');
    }
    return const AuthSession(
      user: AuthUser(
        id: 'USR-10001',
        name: 'John Doe',
        phoneNumber: '251911234567',
        email: 'john.doe@example.com',
        balance: 1250.5,
        currency: 'ETB',
      ),
      token: 'mock_access_token_123456',
      expiresIn: 3600,
    );
  }
}

void main() {
  Widget app() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
      ],
      child: const MyApp(),
    );
  }

  testWidgets('app launches on the auth screen', (WidgetTester tester) async {
    await tester.pumpWidget(app());
    await tester.pump();

    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    expect(find.text('welcome back'), findsOneWidget);
    expect(find.text('Zemdkun Kidane'), findsOneWidget);
    expect(find.text('+251707949336'), findsOneWidget);
    expect(find.text('Enter Your M-PESA PIN'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('forgot PIN?'), findsOneWidget);
    expect(find.text('contact us'), findsOneWidget);
    expect(find.text('terms and conditions'), findsOneWidget);
    expect(find.byIcon(Icons.headset_mic_outlined), findsOneWidget);
    expect(find.byIcon(Icons.description_outlined), findsOneWidget);
  });

  testWidgets('language menu lists English and Amharic', (WidgetTester tester) async {
    await tester.pumpWidget(app());
    await tester.pump();

    await tester.tap(find.text('English'));
    await tester.pump();

    expect(find.text('Amharic'), findsOneWidget);

    await tester.tap(find.text('Amharic'));
    await tester.pump();

    expect(find.text('Amharic'), findsOneWidget);
    expect(find.text('English'), findsNothing);
  });

  testWidgets('wrong PIN shows an error', (WidgetTester tester) async {
    await tester.pumpWidget(app());
    await tester.pump();

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('2'));
      await tester.pump();
    }

    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump();

    expect(find.text('User not found'), findsOneWidget);
    expect(find.byType(AuthScreen), findsOneWidget);
  });

  testWidgets('continue after PIN opens the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(app());
    await tester.pump();

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('1'));
      await tester.pump();
    }

    await tester.tap(find.text('Continue'));
    await tester.pump();
    for (var i = 0; i < 20 && find.byType(HomeScreen).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Hello John 👋'), findsOneWidget);
    expect(find.text('Main Balance (ETB)'), findsOneWidget);
    expect(find.text('********'), findsOneWidget);
    expect(find.text('Merchant\npayment'), findsOneWidget);
    expect(find.text('Bill\npayment'), findsOneWidget);
    expect(find.text('Credit &\nsaving'), findsOneWidget);
    expect(find.text('Transfer\nmoney'), findsOneWidget);
    expect(find.text('Airtime/\npackage'), findsOneWidget);
    expect(find.text('Macro\nservices'), findsOneWidget);
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Bank'), findsWidgets);
    expect(find.text('Airtime Purchase'), findsOneWidget);
    expect(find.text('M-PESA'), findsOneWidget);
    expect(find.byType(HomeScanFab), findsOneWidget);
    expect(find.byIcon(Iconsax.scan), findsOneWidget);
  });
}
