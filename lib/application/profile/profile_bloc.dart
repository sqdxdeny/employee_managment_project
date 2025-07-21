import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(super.initialState) {
    on<_ChangeImage>(_changeImage);
    on<_ChangeLogin>(_changeLogin);
    on<_ChangePassword>(_changePassword);
  }

  Future<void> _changeImage(_ChangeImage event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      image: event.image,
    ));
  }

  Future<void> _changeLogin(_ChangeLogin event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      login: event.login,
    ));
  }

  Future<void> _changePassword(_ChangePassword event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      password: event.password,
    ));
  }
}