import 'package:catbreeds/core/di/network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/remote/breed_remote_datasource_impl.dart';
import '../../data/repositories/breed_repository_impl.dart';
import '../../domain/usecases/get_breeds.dart';

part 'breed_di.g.dart';

@riverpod
BreedRemoteDatasourceImpl breedRemoteDatasource(Ref ref) {
  return BreedRemoteDatasourceImpl(ref.watch(dioProvider));
}

@riverpod
BreedRepositoryImpl breedRepository(Ref ref) {
  return BreedRepositoryImpl(ref.watch(breedRemoteDatasourceProvider));
}

@riverpod
GetBreeds getBreeds(Ref ref) {
  return GetBreeds(ref.watch(breedRepositoryProvider));
}
