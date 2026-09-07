import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:safaricom_test/app/app.dart';
import 'package:safaricom_test/features/auth/presentation/screens/auth_screen.dart';
import 'package:safaricom_test/features/home/presentation/screens/home_screen.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_scan_fab.dart';

void main() {
  testWidgets('app launches on the auth screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
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
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    await tester.tap(find.text('English'));
    await tester.pump();

    expect(find.text('Amharic'), findsOneWidget);

    await tester.tap(find.text('Amharic'));
    await tester.pump();

    expect(find.text('Amharic'), findsOneWidget);
    expect(find.text('English'), findsNothing);
  });

  testWidgets('continue after PIN opens the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('1'));
      await tester.pump();
    }

    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Hello Zemdkun 👋'), findsOneWidget);
    expect(find.text('Main Balance (Birr)'), findsOneWidget);
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
