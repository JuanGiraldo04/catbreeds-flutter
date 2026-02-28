import 'package:catbreeds/core/constants/app_constants.dart';
import 'package:catbreeds/core/router/app_routes.dart';
import 'package:catbreeds/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget buildSubject() {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: AppRoutes.splashPath,
        routes: [
          GoRoute(
            path: AppRoutes.splashPath,
            name: AppRoutes.splashName,
            builder: (_, _) => const SplashPage(),
          ),
          GoRoute(
            path: AppRoutes.breedsPath,
            name: AppRoutes.breedsName,
            builder: (_, _) => const Scaffold(body: Text('Breeds')),
          ),
        ],
      ),
    );
  }

  group('SplashPage', () {
    testWidgets('should display app name', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text(appName), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });

    testWidgets('should display cat logo', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(Image), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });

    testWidgets('should navigate to breeds after delay', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text(appName), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(find.text('Breeds'), findsOneWidget);
      expect(find.text(appName), findsNothing);
    });
  });
}
