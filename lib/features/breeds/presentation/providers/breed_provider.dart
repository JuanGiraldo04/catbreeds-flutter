import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import 'breed_di.dart';

part 'breed_provider.g.dart';

@riverpod
class BreedsNotifier extends _$BreedsNotifier {
  List<Breed> _allBreeds = [];

  @override
  Future<List<Breed>> build() async {
    _allBreeds = await ref.watch(getBreedsProvider).call();
    return _allBreeds;
  }

  void filterByName(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allBreeds);
      return;
    }

    final filtered = _allBreeds
        .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = AsyncData(filtered);
  }
}
