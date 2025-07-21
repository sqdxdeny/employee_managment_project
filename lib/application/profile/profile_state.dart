part of 'profile_bloc.dart';

class ProfileState with EquatableMixin {
  final String? image;
  final String? login;
  final String? password;

  const ProfileState({this.image, this.login, this.password});

  ProfileState copyWith({String? image, String? login, String? password}) {
    return ProfileState(
      image: image ?? this.image,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [image, login, password];
}
