import 'package:catbreeds/features/breeds/data/datasources/remote/breed_remote_datasource.dart';
import 'package:catbreeds/features/breeds/data/models/models.dart';
import 'package:catbreeds/features/breeds/data/repositories/breed_repository_impl.dart';
import 'package:catbreeds/features/breeds/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'breed_repository_impl_test.mocks.dart';

@GenerateMocks([BreedRemoteDatasource])
void main() {
  late MockBreedRemoteDatasource mockDatasource;
  late BreedRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockBreedRemoteDatasource();
    repository = BreedRepositoryImpl(mockDatasource);
  });

  final tWeightModel = const WeightModel(metric: '3 - 5', imperial: '7 - 10');

  final tBreedModels = [
    BreedModel(
      id: 'abys',
      name: 'Abyssinian',
      description: 'A great cat',
      origin: 'Egypt',
      temperament: 'Active, Energetic',
      lifeSpan: '14 - 15',
      referenceImageId: '0XYvRd7oD',
      intelligence: 5,
      adaptability: 5,
      weight: tWeightModel,
    ),
  ];

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

  group('BreedRepositoryImpl', () {
    test('should return list of entities when datasource succeeds', () async {
      when(mockDatasource.getBreeds()).thenAnswer((_) async => tBreedModels);

      final result = await repository.getBreeds();

      expect(result, tBreeds);
      verify(mockDatasource.getBreeds()).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });

    test(
      'should return empty list when datasource returns no models',
      () async {
        when(mockDatasource.getBreeds()).thenAnswer((_) async => []);

        final result = await repository.getBreeds();

        expect(result, isEmpty);
        verify(mockDatasource.getBreeds()).called(1);
      },
    );

    test('should map referenceImageId null to empty string', () async {
      when(mockDatasource.getBreeds()).thenAnswer(
        (_) async => [
          BreedModel(
            id: 'abys',
            name: 'Abyssinian',
            description: 'A great cat',
            origin: 'Egypt',
            temperament: 'Active, Energetic',
            lifeSpan: '14 - 15',
            intelligence: 5,
            adaptability: 5,
            weight: tWeightModel,
          ),
        ],
      );

      final result = await repository.getBreeds();

      expect(result.first.imageId, '');
    });

    test('should throw exception when datasource fails', () async {
      when(mockDatasource.getBreeds()).thenThrow(Exception('Network error'));

      expect(() => repository.getBreeds(), throwsException);
    });
  });
}
