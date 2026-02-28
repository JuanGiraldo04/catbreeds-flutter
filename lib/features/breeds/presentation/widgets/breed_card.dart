import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/domain.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;

  const BreedCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: breed.imageId,
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(breed.imageId),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, _, _) => const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => context.pushNamed(
                    AppRoutes.breedDetailName,
                    pathParameters: {'id': breed.id},
                    extra: breed,
                  ),
                  child: const Text(AppStrings.more),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(breed.name, style: theme.textTheme.titleMedium),
                    Text(breed.origin, style: theme.textTheme.bodySmall),
                  ],
                ),
                Text(
                  '${AppStrings.intelligence} ${breed.intelligence} / 5',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
