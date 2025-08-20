import 'package:equatable/equatable.dart';
import 'package:uuid/v1.dart';

class Profile with EquatableMixin {
  final UuidV1 id;
  final String? image;
  final String? login;
  final String? password;

  Profile({UuidV1? id, this.image, this.login, this.password})
    : id = id ?? UuidV1();

  Profile copyWith({String? image, String? login, String? password}) {
    return Profile(
      id: id,
      image: image ?? this.image,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, image, login, password];
}
