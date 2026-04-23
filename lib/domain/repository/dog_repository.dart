import 'package:assignment_dog/core/error/failure.dart';
import 'package:assignment_dog/core/utils/dartz/either.dart';
import 'package:assignment_dog/data/models/dog_breed_model.dart';

abstract class DogBreedRepository {
  Future<Either<Failure, List<DogBreedModel>?>> getBreeds({
    required int pageNumber,
  });
}
