import 'package:catbreeds/features/breeds/domain/domain.dart';
import 'package:catbreeds/features/breeds/presentation/providers/breed_di.dart';
import 'package:catbreeds/features/breeds/presentation/providers/breed_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'breeds_notifier_test.mocks.dart';

@GenerateMocks([GetBreeds])
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
    const Breed(
      id: 'beng',
      name: 'Bengal',
      description: 'An energetic cat',
      origin: 'United States',
      temperament: 'Alert, Agile',
      lifeSpan: '12 - 15',
      imageId: 'O3btzLlsO',
      intelligence: 5,
      adaptability: 5,
      weight: Weight(metric: '3 - 7', imperial: '6 - 12'),
    ),
  ];

  late MockGetBreeds mockGetBreeds;

  setUp(() {
    mockGetBreeds = MockGetBreeds();
  });

  ProviderContainer buildContainer() {
    return ProviderContainer(
      overrides: [getBreedsProvider.overrideWithValue(mockGetBreeds)],
    );
  }

  group('BreedsNotifier', () {
    test('should load breeds on build', () async {
      when(mockGetBreeds.call()).thenAnswer((_) async => tBreeds);

      final container = buildContainer();
      addTearDown(container.dispose);

      final result = await container.read(breedsNotifierProvider.future);

      expect(result, tBreeds);
    });

    test('should filter breeds by name', () async {
      when(mockGetBreeds.call()).thenAnswer((_) async => tBreeds);

      final container = buildContainer();
      addTearDown(container.dispose);

      await container.read(breedsNotifierProvider.future);
      container.read(breedsNotifierProvider.notifier).filterByName('abys');

      final filtered = container.read(breedsNotifierProvider).value;
      expect(filtered?.length, 1);
      expect(filtered?.first.name, 'Abyssinian');
    });

    test('should return all breeds when query is empty', () async {
      when(mockGetBreeds.call()).thenAnswer((_) async => tBreeds);

      final container = buildContainer();
      addTearDown(container.dispose);

      await container.read(breedsNotifierProvider.future);
      container.read(breedsNotifierProvider.notifier).filterByName('abys');
      container.read(breedsNotifierProvider.notifier).filterByName('');

      final result = container.read(breedsNotifierProvider).value;
      expect(result?.length, tBreeds.length);
    });

    test('should return empty list when no breed matches query', () async {
      when(mockGetBreeds.call()).thenAnswer((_) async => tBreeds);

      final container = buildContainer();
      addTearDown(container.dispose);

      await container.read(breedsNotifierProvider.future);
      container.read(breedsNotifierProvider.notifier).filterByName('xyz');

      final result = container.read(breedsNotifierProvider).value;
      expect(result, isEmpty);
    });
  });
}
