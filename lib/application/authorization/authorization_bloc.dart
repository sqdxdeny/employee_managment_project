import 'dart:async';

import 'package:employee_managment_project/application/profile_watcher/profile_watcher_bloc.dart';
import 'package:employee_managment_project/domain/profile/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final ProfileWatcherBloc _profileWatcherBloc;

  late StreamSubscription<ProfileWatcherState> _profileListener;

  AuthorizationBloc(this._profileWatcherBloc)
    : super(AuthorizationState.initial(_profileWatcherBloc.state.profile)) {
    on<_UpdateLogin>(_updateLogin);
    on<_UpdatePassword>(_updatePassword);
    on<_Authorize>(_authorize);
    on<_Refresh>(_refresh);

    _profileListener = _profileWatcherBloc.stream.listen((updated) {
      if (state.profile != updated.profile) {
        add(AuthorizationEvent.refresh(updated.profile));
      }
    });
  }

  @override
  Future<void> close() async {
    _profileListener.cancel();
    super.close();
  }

  Future<void> _refresh(
    _Refresh event,
    Emitter<AuthorizationState> emit,
  ) async {
    print('refresh: ${event.profile.toString()}');
    emit(AuthorizationState.initial(event.profile));
  }

  Future<void> _updateLogin(
    _UpdateLogin event,
    Emitter<AuthorizationState> emit,
  ) async {
    emit(state.copyWith(login: event.login));
  }

  Future<void> _updatePassword(
    _UpdatePassword event,
    Emitter<AuthorizationState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _authorize(
    _Authorize event,
    Emitter<AuthorizationState> emit,
  ) async {
    final profile = state.validate ? null : state.profile;
    _profileWatcherBloc.add(ProfileWatcherEvent.authorize(profile));
  }
}
