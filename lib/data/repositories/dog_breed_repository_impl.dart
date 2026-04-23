import 'package:assignment_dog/core/error/failure.dart';
import 'package:assignment_dog/core/utils/dartz/either.dart';
import 'package:assignment_dog/data/models/dog_breed_model.dart';
import 'package:assignment_dog/domain/repository/dog_repository.dart';
import '../datasources/dog_breed_remote_datasource.dart';

class DogBreedRepositoryImpl implements DogBreedRepository {
  final DogBreedRemoteDataSource dataSource;

  DogBreedRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DogBreedModel>?>> getBreeds({
    required int pageNumber,
  }) async {
    try {
      final data = await dataSource.getBreeds(pageNumber: pageNumber);
      if (data.data != null) {
        return Right(data.data);
      } else {
        return Left(ServerFailure(message: data.errorMessage ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
