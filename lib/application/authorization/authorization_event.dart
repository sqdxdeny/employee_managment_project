part of 'authorization_bloc.dart';

sealed class AuthorizationEvent {
  const AuthorizationEvent();

  const factory AuthorizationEvent.updateLogin(String login) = _UpdateLogin;

  const factory AuthorizationEvent.updatePassword(String password) =
      _UpdatePassword;

  const factory AuthorizationEvent.authorize() = _Authorize;

  const factory AuthorizationEvent.refresh(Profile profile) = _Refresh;
}

class _UpdateLogin extends AuthorizationEvent {
  final String login;

  const _UpdateLogin(this.login);
}

class _UpdatePassword extends AuthorizationEvent {
  final String password;

  const _UpdatePassword(this.password);
}

class _Authorize extends AuthorizationEvent {
  const _Authorize();
}

class _Refresh extends AuthorizationEvent {
  final Profile profile;

  const _Refresh(this.profile);
}
