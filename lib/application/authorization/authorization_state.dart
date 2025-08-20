part of 'authorization_bloc.dart';

class AuthorizationState with EquatableMixin {
  final String? login;
  final String? password;
  final String? loginValidator;
  final String? passwordValidator;

  const AuthorizationState({
    this.login,
    this.password,
    this.loginValidator,
    this.passwordValidator,
  });

  factory AuthorizationState.initial(Profile profile) {
    print('initial: ${profile.toString()}');
    return AuthorizationState(
      loginValidator: profile.login,
      passwordValidator: profile.password,
    );
  }

  AuthorizationState copyWith({String? login, String? password}) {
    return AuthorizationState(
      login: login ?? this.login,
      password: password ?? this.password,
      loginValidator: loginValidator,
      passwordValidator: passwordValidator,
    );
  }

  @override
  List<Object?> get props => [login, password];
}

extension AuthorizationStateX on AuthorizationState {
  bool get enableAuth {
    final login = this.login;
    final password = this.password;
    final res =
        login != null &&
        login.isNotEmpty &&
        password != null &&
        password.isNotEmpty;
    return res;
  }

  bool get validate {
    final loginValidator = this.loginValidator;
    final passwordValidator = this.passwordValidator;
    print(
      'IN VALIDATE: loginValidator $loginValidator, passwordValidator $passwordValidator',
    );
    if (loginValidator == null || passwordValidator == null) return false;
    return true;
  }

  bool get enableNavigate {
    print('validate: ${!validate}');
    if (!validate) return true;
    if (login != loginValidator || password != passwordValidator) return false;
    return true;
  }

  Profile get profile {
    return Profile(login: login, password: password);
  }
}
