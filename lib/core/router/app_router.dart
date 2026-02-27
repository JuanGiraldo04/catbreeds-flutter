import 'package:catbreeds/core/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/breeds/presentation/pages/pages.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splashPath,
    routes: [
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.breedsPath,
        name: AppRoutes.breedsName,
        builder: (context, state) => const BreedsPage(),
      ),
      GoRoute(
        path: AppRoutes.breedDetailPath,
        name: AppRoutes.breedDetailName,
        builder: (context, state) => const BreedDetailPage(),
      ),
    ],
    debugLogDiagnostics: true,
  );
}
