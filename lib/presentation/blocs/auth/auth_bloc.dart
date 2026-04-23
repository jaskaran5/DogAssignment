import 'dart:async';

import 'package:assignment_dog/config/helper.dart';
import 'package:assignment_dog/config/validator.dart';
import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:assignment_dog/core/utils/routing/routes.dart';
import 'package:assignment_dog/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginOrRegisterEvent>(_loginAndRegitserApi);
    on<LogOutAndDeleteEvent>(_logOut);
    on<ToggleShowPassEvent>(_toggleShowPass);
    on<StoreUserDaataEvent>(_storeUserToState);
    add(StoreUserDaataEvent());
  }

  final password = TextEditingController();
  final userName = TextEditingController();

  FutureOr<void> _loginAndRegitserApi(
    LoginOrRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState(status: AuthStatus.loading));
    final isValid = Validator().loginAndSignUpValidator(
      userName: userName.text.trim(),
      password: password.text.trim(),
    );

    if (isValid) {
      emit(AuthState(status: AuthStatus.loaded));
      await Getters.getLocalStorage.authenticate(
        UserModel(
          password: password.text.trim(),
          username: userName.text.trim(),
        ),
      );

      UserModel? currentUser = await Getters.getLocalStorage.getCurrentUser();

      /// store the current user value into the user
      emit(state.copyWith(status: AuthStatus.success, user: currentUser));

      offAllNamed(Getters.getContext!, Routes.home);
    } else {
      emit(
        AuthState(status: AuthStatus.error, errorMessage: Validator().error),
      );
    }
  }

  FutureOr<void> _logOut(
    LogOutAndDeleteEvent event,
    Emitter<AuthState> emit,
  ) async {
    final storage = Getters.getLocalStorage;
    if (event.isFromDelete) {
      storage.clearSession().then((value) {
        offAllNamed(Getters.getContext!, Routes.login);
      });
    } else {
      storage.logout().then((value) {
        offAllNamed(Getters.getContext!, Routes.login);
      });
    }
  }

  FutureOr<void> _toggleShowPass(
    ToggleShowPassEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        isPasswordVisible: !state.isPasswordVisible,
        errorMessage: '',
        user: null,
      ),
    );
  }

  FutureOr<void> _storeUserToState(
    StoreUserDaataEvent event,
    Emitter<AuthState> emit,
  ) async {
    UserModel? currentUser = await Getters.getLocalStorage.getCurrentUser();
    emit(state.copyWith(user: currentUser));
  }
}
