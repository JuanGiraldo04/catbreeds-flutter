import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class BreedsPage extends ConsumerWidget {
  const BreedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(breedsNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SearchBar(
              hintText: AppStrings.searchHint,
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              backgroundColor: WidgetStateProperty.all(
                theme.colorScheme.surface,
              ),
              side: WidgetStateProperty.all(
                BorderSide(color: theme.colorScheme.outline),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              onChanged: (query) =>
                  ref.read(breedsNotifierProvider.notifier).filterByName(query),
              leading: Icon(Icons.search, color: theme.colorScheme.onSurface),
            ),
          ),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (breeds) => breeds.isEmpty
                  ? const Center(child: Text(AppStrings.noBreedsFound))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: breeds.length,
                      itemBuilder: (_, i) => BreedCard(breed: breeds[i]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
