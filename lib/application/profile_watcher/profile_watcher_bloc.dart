import 'package:employee_managment_project/domain/profile/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_watcher_event.dart';
part 'profile_watcher_state.dart';

class ProfileWatcherBloc
    extends Bloc<ProfileWatcherEvent, ProfileWatcherState> {
  ProfileWatcherBloc() : super(ProfileWatcherState.initial()) {
    on<_UpdateProfile>(_updateProfile);
    on<_Authorize>(_authorize);
    on<_SignOut>(_signOut);
  }

  Future<void> _updateProfile(
    _UpdateProfile event,
    Emitter<ProfileWatcherState> emit,
  ) async {
    emit(state.copyWith(profile: event.profile));
  }

  Future<void> _authorize(
    _Authorize event,
    Emitter<ProfileWatcherState> emit,
  ) async {
    emit(state.copyWith(isAuthorization: true, profile: event.profile));
  }

  Future<void> _signOut(
    _SignOut event,
    Emitter<ProfileWatcherState> emit,
  ) async {
    emit(state.copyWith(isAuthorization: false));
  }
}
