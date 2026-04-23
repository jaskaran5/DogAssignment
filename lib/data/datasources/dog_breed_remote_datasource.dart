import 'package:assignment_dog/config/app_constants.dart';
import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:assignment_dog/core/network/http_service.dart';
import 'package:assignment_dog/core/response_wrapper/data_response.dart';

import '../models/dog_breed_model.dart';

abstract class DogBreedRemoteDataSource {
  Future<ResponseWrapper<List<DogBreedModel>?>> getBreeds({
    required int pageNumber,
  });
}

class DogBreedRemoteDataSourceImpl implements DogBreedRemoteDataSource {
  DogBreedRemoteDataSourceImpl();

  @override
  Future<ResponseWrapper<List<DogBreedModel>>> getBreeds({
    required int pageNumber,
  }) async {
    try {
      final response = await Getters.getHttpService
          .request<List<DogBreedModel>>(
            url: AppConstants.getBreads,
            requestType: RequestType.get,
            body: {'page[number]': pageNumber, 'page[size]': 10},
            fromJson: (json) =>
                (json as List).map((e) => DogBreedModel.fromJson(e)).toList(),
          );

      if (response.data != null) {
        return getSuccessResponseWrapper(response);
      } else {
        return getFailedResponseWrapper(
          response.errorMessage ?? "Failed to load breeds",
        );
      }
    } catch (e) {
      return getFailedResponseWrapper(
        exceptionHandler(e: e, functionName: "getBreeds"),
      );
    }
  }
}
