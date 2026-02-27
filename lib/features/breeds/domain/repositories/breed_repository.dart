import '../entities/entities.dart';

abstract interface class BreedRepository {
  Future<List<Breed>> getBreeds();
}
