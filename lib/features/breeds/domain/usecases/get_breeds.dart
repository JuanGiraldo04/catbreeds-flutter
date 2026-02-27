import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetBreeds {
  final BreedRepository repository;

  const GetBreeds(this.repository);

  Future<List<Breed>> call() => repository.getBreeds();
}
