import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/breed.dart';

part 'breed_model.freezed.dart';
part 'breed_model.g.dart';

@freezed
abstract class BreedModel with _$BreedModel {
  const factory BreedModel({
    required String id,
    required String name,
    required String description,
    required String origin,
    required String temperament,
    @JsonKey(name: 'life_span') required String lifeSpan,
    @JsonKey(name: 'reference_image_id') String? referenceImageId,
    required WeightModel weight,
  }) = _BreedModel;

  factory BreedModel.fromJson(Map<String, dynamic> json) =>
      _$BreedModelFromJson(json);
}

@freezed
abstract class WeightModel with _$WeightModel {
  const factory WeightModel({
    required String metric,
    required String imperial,
  }) = _WeightModel;

  factory WeightModel.fromJson(Map<String, dynamic> json) =>
      _$WeightModelFromJson(json);
}

extension BreedModelX on BreedModel {
  Breed toEntity() => Breed(
    id: id,
    name: name,
    description: description,
    origin: origin,
    temperament: temperament,
    lifeSpan: lifeSpan,
    imageId: referenceImageId ?? '',
    weight: weight.toEntity(),
  );
}

extension WeightModelX on WeightModel {
  Weight toEntity() => Weight(metric: metric, imperial: imperial);
}
