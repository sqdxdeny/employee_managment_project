part of 'authorization_bloc.dart';

class AuthorizationState with EquatableMixin {
  final String? login;
  final String? password;

  const AuthorizationState ({
    this.login,
    this.password,
});

  AuthorizationState copyWith({
    String? login,
    String? password,
}) {
    return AuthorizationState(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    login,
    password,
  ];
}