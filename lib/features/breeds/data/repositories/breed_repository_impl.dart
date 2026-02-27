import '../../domain/domain.dart';
import '../datasources/remote/breed_remote_datasource.dart';
import '../models/models.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedRemoteDatasource _datasource;

  const BreedRepositoryImpl(this._datasource);

  @override
  Future<List<Breed>> getBreeds() async {
    final models = await _datasource.getBreeds();
    return models.map((model) => model.toEntity()).toList();
  }
}
