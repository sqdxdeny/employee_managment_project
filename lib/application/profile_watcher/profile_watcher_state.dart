part of 'profile_watcher_bloc.dart';

class ProfileWatcherState with EquatableMixin {
  final Profile profile;
  final bool isAuthorization;

  const ProfileWatcherState({
    required this.profile,
    required this.isAuthorization,
  });

  factory ProfileWatcherState.initial() {
    return ProfileWatcherState(profile: Profile(), isAuthorization: false);
  }

  ProfileWatcherState copyWith({Profile? profile, bool? isAuthorization}) {
    return ProfileWatcherState(
      profile: profile ?? this.profile,
      isAuthorization: isAuthorization ?? this.isAuthorization,
    );
  }

  @override
  List<Object?> get props => [profile, isAuthorization];
}
