import 'package:assignment_dog/data/models/dog_breed_model.dart';
import 'package:assignment_dog/domain/repository/dog_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';

abstract class DogBreedUseCase {
  Future<Either<Failure, List<DogBreedModel>?>> getDogBreadApi({
    required int pageNumber,
  });
}

class DogBreedUseCaseImpl implements DogBreedUseCase {
  final DogBreedRepository repository;

  DogBreedUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<DogBreedModel>?>> getDogBreadApi({
    required int pageNumber,
  }) async {
    final result = await repository.getBreeds(pageNumber: pageNumber);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
