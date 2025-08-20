part of 'profile_editor_bloc.dart';

class ProfileEditorState with EquatableMixin {
  final UuidV1 id;
  final String? image;
  final String? login;
  final String? password;

  const ProfileEditorState({
    required this.id,
    this.image,
    this.login,
    this.password,
  });

  factory ProfileEditorState.initial(Profile profile) {
    return ProfileEditorState(
      id: profile.id,
      login: profile.login,
      password: profile.password,
      image: profile.image,
    );
  }

  ProfileEditorState copyWith({
    String? image,
    String? login,
    String? password,
  }) {
    return ProfileEditorState(
      id: id,
      image: image ?? this.image,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [image, login, password];
}

extension ProfileEditorStateX on ProfileEditorState {
  Profile get profile {
    return Profile(id: id, image: image, login: login, password: password);
  }

  bool get enableSave {
    final login = this.login;
    final password = this.password;
    final res = login != null && login.isNotEmpty && password != null && password.isNotEmpty;
    return res;
  }
}
