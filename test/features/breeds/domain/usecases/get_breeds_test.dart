import 'package:catbreeds/features/breeds/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_breeds_test.mocks.dart';

@GenerateMocks([BreedRepository])
void main() {
  late MockBreedRepository mockRepository;
  late GetBreeds useCase;

  setUp(() {
    mockRepository = MockBreedRepository();
    useCase = GetBreeds(mockRepository);
  });

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

  group('GetBreeds', () {
    test('should return list of breeds from repository', () async {
      when(mockRepository.getBreeds()).thenAnswer((_) async => tBreeds);

      final result = await useCase();

      expect(result, tBreeds);
      verify(mockRepository.getBreeds()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
      'should return empty list when repository returns no breeds',
      () async {
        when(mockRepository.getBreeds()).thenAnswer((_) async => []);

        final result = await useCase();

        expect(result, isEmpty);
        verify(mockRepository.getBreeds()).called(1);
      },
    );

    test('should throw exception when repository fails', () async {
      when(mockRepository.getBreeds()).thenThrow(Exception('Network error'));

      expect(() => useCase(), throwsException);
    });
  });
}
