import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed.freezed.dart';

@freezed
abstract class Breed with _$Breed {
  const factory Breed({
    required String id,
    required String name,
    required String description,
    required String origin,
    required String temperament,
    required String lifeSpan,
    required String imageId,
    required Weight weight,
  }) = _Breed;
}

@freezed
abstract class Weight with _$Weight {
  const factory Weight({required String metric, required String imperial}) =
      _Weight;
}
