import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogOutAndDeleteEvent extends AuthEvent {
  final bool isFromDelete;
  const LogOutAndDeleteEvent({this.isFromDelete = false});

  @override
  List<Object?> get props => [isFromDelete];
}

class StoreUserDaataEvent extends AuthEvent {
  const StoreUserDaataEvent();

  @override
  List<Object?> get props => [];
}

class ToggleShowPassEvent extends AuthEvent {
  const ToggleShowPassEvent();

  @override
  List<Object?> get props => [];
}

class LoginOrRegisterEvent extends AuthEvent {
  const LoginOrRegisterEvent();

  @override
  List<Object?> get props => [];
}
