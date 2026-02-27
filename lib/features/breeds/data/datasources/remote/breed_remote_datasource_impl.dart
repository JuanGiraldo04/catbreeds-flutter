import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../models/models.dart';
import 'breed_remote_datasource.dart';

class BreedRemoteDatasourceImpl implements BreedRemoteDatasource {
  final Dio _dio;

  const BreedRemoteDatasourceImpl(this._dio);

  @override
  Future<List<BreedModel>> getBreeds() async {
    final response = await _dio.get(ApiConstants.breedsPath);
    return (response.data as List)
        .map((e) => BreedModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
