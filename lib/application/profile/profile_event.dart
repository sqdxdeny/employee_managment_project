part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();

  const factory ProfileEvent.changeImage(String image) = _ChangeImage;

  const factory ProfileEvent.changeLogin(String login) = _ChangeLogin;

  const factory ProfileEvent.changePassword(String password) = _ChangePassword;

}

  class _ChangeImage extends ProfileEvent {
    final String image;

    const _ChangeImage(this.image);
}

class _ChangeLogin extends ProfileEvent {
  final String login;

  const _ChangeLogin(this.login);
}

class _ChangePassword extends ProfileEvent {
  final String password;

  const _ChangePassword(this.password);
}
