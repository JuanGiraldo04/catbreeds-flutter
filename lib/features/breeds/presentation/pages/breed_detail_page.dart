import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/domain.dart';

class BreedDetailPage extends StatelessWidget {
  final Breed breed;

  const BreedDetailPage({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(breed.name)),
      body: Column(
        children: [
          Hero(
            tag: breed.imageId,
            child: CachedNetworkImage(
              imageUrl: ApiConstants.imageUrl(breed.imageId),
              width: double.infinity,
              height: size.height * 0.45,
              fit: BoxFit.cover,
              placeholder: (_, _) => SizedBox(
                height: size.height * 0.4,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, _, _) => SizedBox(
                height: size.height * 0.4,
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(breed.description, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 24),
                    _InfoRow(label: AppStrings.origin, value: breed.origin),
                    _InfoRow(
                      label: AppStrings.temperament,
                      value: breed.temperament,
                    ),
                    _InfoRow(
                      label: AppStrings.lifeSpan,
                      value: '${breed.lifeSpan} ${AppStrings.years}',
                    ),
                    _InfoRow(
                      label: AppStrings.weight,
                      value: '${breed.weight.metric} kg',
                    ),
                    _InfoRow(
                      label: AppStrings.intelligence,
                      value: '${breed.intelligence} / 5',
                    ),
                    _InfoRow(
                      label: AppStrings.adaptability,
                      value: '${breed.adaptability} / 5',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
