import 'package:assignment_dog/domain/usecases/dog_breed_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../network/http_service.dart';
import '../network/network_info.dart';
import '../local_storage/local_storage.dart';

/// general getter

class Getters {
  Getters._();

  static GlobalKey<NavigatorState> get navKey =>
      GetIt.I.get<GlobalKey<NavigatorState>>();

  static DateTime get now => DateTime.now();

  static LocalStorage get getLocalStorage => GetIt.I.get<LocalStorage>();

  static HttpService get getHttpService => GetIt.I.get<HttpService>();

  static NetworkInfo get networkInfo => GetIt.I.get<NetworkInfo>();

  static BuildContext? get getContext => navKey.currentContext;

  static DogBreedUseCase get getDogRepo => GetIt.I.get<DogBreedUseCase>();

  // static String? get authToken => GetIt.I.get<LocalStorage>().getToken();

  // static bool get isLoggedIn =>
  //     GetIt.I.get<LocalStorage>().getIsProfileComplete() == 1;

  //static bool get hasProfileDate => GetIt.I.get<LocalStorage>().getLoginUser()?.firstName != null;
}
