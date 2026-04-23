import 'dart:async';
import 'package:assignment_dog/config/app_constants.dart';
import 'package:assignment_dog/data/datasources/dog_breed_remote_datasource.dart';
import 'package:assignment_dog/data/repositories/dog_breed_repository_impl.dart';
import 'package:assignment_dog/domain/repository/dog_repository.dart';
import 'package:assignment_dog/domain/usecases/dog_breed_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../local_storage/local_storage.dart';
import '../network/http_service.dart';
import '../network/interceptor.dart';
import '../network/network_info.dart';

typedef AppRunner = FutureOr<void> Function();

class AppInjector {
  static Future<void> init({required AppRunner appRunner}) async {
    await _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    await Hive.initFlutter(AppConstants.boxName);
    await GetIt.I.allReady();
    final storage = await HiveStorageImp.init();
    GetIt.I.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>(),
    );
    GetIt.I.registerLazySingleton<LocalStorage>(() => storage);
    GetIt.I.registerLazySingleton<Injector>(() => Injector());
    GetIt.I.registerLazySingleton<Connectivity>(() => Connectivity());
    GetIt.I.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementation(GetIt.I<Connectivity>()),
    );
    GetIt.I.registerLazySingleton<HttpService>(() => HttpService());
    GetIt.I.registerLazySingleton<DogBreedRemoteDataSource>(
      () => DogBreedRemoteDataSourceImpl(),
    );
    GetIt.I.registerLazySingleton<DogBreedRepository>(
      () => DogBreedRepositoryImpl(
        dataSource: GetIt.I<DogBreedRemoteDataSource>(),
      ),
    );
    GetIt.I.registerLazySingleton<DogBreedUseCase>(
      () => DogBreedUseCaseImpl(repository: GetIt.I<DogBreedRepository>()),
    );
  }
}
