import 'package:catbreeds/core/constants/app_strings.dart';
import 'package:catbreeds/features/breeds/domain/domain.dart';
import 'package:catbreeds/features/breeds/presentation/pages/breeds_page.dart';
import 'package:catbreeds/features/breeds/presentation/providers/breed_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  final tBreeds = [
    const Breed(
      id: 'abys',
      name: 'Abyssinian',
      description: 'A great cat',
      origin: 'Egypt',
      temperament: 'Active, Energetic',
      lifeSpan: '14 - 15',
      imageId: '0XYvRd7oD',
      intelligence: 5,
      adaptability: 5,
      weight: Weight(metric: '3 - 5', imperial: '7 - 10'),
    ),
  ];

  Widget buildSubject({required AsyncValue<List<Breed>> state}) {
    return ProviderScope(
      overrides: [
        breedsNotifierProvider.overrideWith(() => _FakeBreedsNotifier(state)),
      ],
      child: MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/breeds',
          routes: [
            GoRoute(path: '/breeds', builder: (_, _) => const BreedsPage()),
            GoRoute(path: '/breeds/:id', builder: (_, _) => const Scaffold()),
          ],
        ),
      ),
    );
  }

  group('BreedsPage', () {
    testWidgets('should show loading indicator', (tester) async {
      await tester.pumpWidget(buildSubject(state: const AsyncLoading()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show breeds list when data loads', (tester) async {
      await tester.pumpWidget(buildSubject(state: AsyncData(tBreeds)));
      await tester.pump();

      expect(find.text('Abyssinian'), findsOneWidget);
    });

    testWidgets('should show empty message when no breeds found', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject(state: const AsyncData([])));

      expect(find.text(AppStrings.noBreedsFound), findsOneWidget);
    });

    testWidgets('should show error view when state is error', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          state: AsyncError(Exception('Network error'), StackTrace.empty),
        ),
      );

      expect(find.text(AppStrings.errorMessage), findsOneWidget);
      expect(find.text(AppStrings.retry), findsOneWidget);
    });

    testWidgets('should show search bar', (tester) async {
      await tester.pumpWidget(buildSubject(state: AsyncData(tBreeds)));

      expect(find.byType(SearchBar), findsOneWidget);
    });
  });
}

class _FakeBreedsNotifier extends BreedsNotifier {
  final AsyncValue<List<Breed>> _state;

  _FakeBreedsNotifier(this._state);

  @override
  Future<List<Breed>> build() async {
    state = _state;
    return _state.value ?? [];
  }
}
