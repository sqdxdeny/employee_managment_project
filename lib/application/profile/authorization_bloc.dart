import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc(super.initialState) {
    on<_UpdateLogin>(_updateLogin);
    on<_UpdatePassword>(_updatePassword);
  }

  Future<void> _updateLogin(_UpdateLogin event, Emitter<AuthorizationState> emit) async {
    emit(state.copyWith(
      login: event.login,
    ));
  }

  Future<void> _updatePassword(_UpdatePassword event, Emitter<AuthorizationState> emit) async {
    emit(state.copyWith(
      password: event.password,
    ));
  }
}