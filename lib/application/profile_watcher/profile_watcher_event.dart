part of 'profile_watcher_bloc.dart';

sealed class ProfileWatcherEvent {
  const ProfileWatcherEvent();

  const factory ProfileWatcherEvent.updateProfile(Profile profile) =
      _UpdateProfile;

  const factory ProfileWatcherEvent.authorize(Profile? profile) = _Authorize;

  const factory ProfileWatcherEvent.signOut() = _SignOut;
}

class _UpdateProfile extends ProfileWatcherEvent {
  final Profile profile;

  const _UpdateProfile(this.profile);
}

class _Authorize extends ProfileWatcherEvent {
  final Profile? profile;

  const _Authorize(this.profile);
}

class _SignOut extends ProfileWatcherEvent {
  const _SignOut();
}
