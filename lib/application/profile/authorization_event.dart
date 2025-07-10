part of 'authorization_bloc.dart';


sealed class AuthorizationEvent {
  const AuthorizationEvent();

  const factory AuthorizationEvent.updateLogin(String login) = _UpdateLogin;

  const factory AuthorizationEvent.updatePassword(
      String password) = _UpdatePassword;

  const factory AuthorizationEvent.isButtonEnabled(bool buttonenabled) = _isButtonEnabled;

}

class _UpdateLogin extends AuthorizationEvent {
  final String login;
  const _UpdateLogin(this.login);
}

class _UpdatePassword extends AuthorizationEvent {
  final String password;
  const _UpdatePassword(this.password);
}

class _isButtonEnabled extends AuthorizationEvent {
  final bool isButtonEnabled;
  const _isButtonEnabled(this.isButtonEnabled);

}