import '../../models/models.dart';

abstract interface class BreedRemoteDatasource {
  Future<List<BreedModel>> getBreeds();
}
