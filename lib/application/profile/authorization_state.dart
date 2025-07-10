part of 'authorization_bloc.dart';

class AuthorizationState with EquatableMixin {
  final String? login;
  final String? password;
  final bool isButtonEnabled;

  const AuthorizationState ({
    this.login,
    this.password,
    this.isButtonEnabled = false,
});

  AuthorizationState copyWith({
    String? login,
    String? password,
    bool? isButtonEnabled,
}) {
    return AuthorizationState(
      login: login ?? this.login,
      password: password ?? this.password,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
    login,
    password,
    isButtonEnabled,
  ];
}