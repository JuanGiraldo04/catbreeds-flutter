import 'package:catbreeds/core/constants/app_strings.dart';
import 'package:catbreeds/features/breeds/domain/domain.dart';
import 'package:catbreeds/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tBreed = Breed(
    id: 'abys',
    name: 'Abyssinian',
    description: 'A great cat breed.',
    origin: 'Egypt',
    temperament: 'Active, Energetic',
    lifeSpan: '14 - 15',
    imageId: '0XYvRd7oD',
    intelligence: 5,
    adaptability: 5,
    weight: Weight(metric: '3 - 5', imperial: '7 - 10'),
  );

  Widget buildSubject() {
    return const MaterialApp(home: BreedDetailPage(breed: tBreed));
  }

  group('BreedDetailPage', () {
    testWidgets('should display breed name in app bar', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(tBreed.name), findsOneWidget);
    });

    testWidgets('should display breed description', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(tBreed.description), findsOneWidget);
    });

    testWidgets('should display origin label and value', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(AppStrings.origin), findsOneWidget);
      expect(find.text(tBreed.origin), findsOneWidget);
    });

    testWidgets('should display intelligence label', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(AppStrings.intelligence), findsOneWidget);
    });

    testWidgets('should display adaptability label', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(AppStrings.adaptability), findsOneWidget);
    });

    testWidgets('should display life span label', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text(AppStrings.lifeSpan), findsOneWidget);
    });
  });
}
