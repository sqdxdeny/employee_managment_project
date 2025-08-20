import 'dart:async';

import 'package:employee_managment_project/application/profile_watcher/profile_watcher_bloc.dart';
import 'package:employee_managment_project/domain/profile/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v1.dart';

part 'profile_editor_event.dart';
part 'profile_editor_state.dart';

class ProfileEditorBloc extends Bloc<ProfileEditorEvent, ProfileEditorState> {
  final ProfileWatcherBloc _watcherBloc;

  late StreamSubscription<ProfileWatcherState> _profileListener;

  ProfileEditorBloc(this._watcherBloc)
    : super(ProfileEditorState.initial(_watcherBloc.state.profile)) {
    on<_Refresh>(_refresh);
    on<_ChangeImage>(_changeImage);
    on<_ChangeLogin>(_changeLogin);
    on<_ChangePassword>(_changePassword);
    on<_Save>(_save);

    _profileListener = _watcherBloc.stream.listen((updated) {
      if (state.profile != updated.profile) {
        add(ProfileEditorEvent.refresh(updated.profile));
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
    Emitter<ProfileEditorState> emit,
  ) async {
    emit(ProfileEditorState.initial(event.profile));
  }

  Future<void> _changeImage(
    _ChangeImage event,
    Emitter<ProfileEditorState> emit,
  ) async {
    emit(state.copyWith(image: event.image));
  }

  Future<void> _changeLogin(
    _ChangeLogin event,
    Emitter<ProfileEditorState> emit,
  ) async {
    emit(state.copyWith(login: event.login));
  }

  Future<void> _changePassword(
    _ChangePassword event,
    Emitter<ProfileEditorState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _save(_Save event, Emitter<ProfileEditorState> emit) async {
    _watcherBloc.add(ProfileWatcherEvent.updateProfile(state.profile));
  }
}
