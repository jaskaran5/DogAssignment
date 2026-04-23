import 'package:assignment_dog/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, loaded, error, success }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final bool isPasswordVisible;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.isPasswordVisible = false,
  });
  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
    bool? isPasswordVisible,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [status, user, isPasswordVisible, errorMessage];
}
