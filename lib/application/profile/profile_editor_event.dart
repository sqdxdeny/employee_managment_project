part of 'profile_editor_bloc.dart';

sealed class ProfileEditorEvent {
  const ProfileEditorEvent();

  const factory ProfileEditorEvent.changeImage(String image) = _ChangeImage;

  const factory ProfileEditorEvent.changeLogin(String login) = _ChangeLogin;

  const factory ProfileEditorEvent.changePassword(String password) =
      _ChangePassword;

  const factory ProfileEditorEvent.save() = _Save;

  const factory ProfileEditorEvent.refresh(Profile profile) = _Refresh;
}

class _ChangeImage extends ProfileEditorEvent {
  final String image;

  const _ChangeImage(this.image);
}

class _ChangeLogin extends ProfileEditorEvent {
  final String login;

  const _ChangeLogin(this.login);
}

class _ChangePassword extends ProfileEditorEvent {
  final String password;

  const _ChangePassword(this.password);
}

class _Save extends ProfileEditorEvent {
  const _Save();
}

class _Refresh extends ProfileEditorEvent {
  final Profile profile;

  const _Refresh(this.profile);
}
