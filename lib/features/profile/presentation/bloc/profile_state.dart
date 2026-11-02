part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileStateLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileStateEmpty extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileStateError extends ProfileState {
  final String message;
  const ProfileStateError(this.message);
  @override
  List<Object> get props => [message];
}

class ProfileStateLoadedAllUsers extends ProfileState {
  final List<Profile> allUsers;
  const ProfileStateLoadedAllUsers(this.allUsers);
  @override
  List<Object> get props => [allUsers];
}

class ProfileStateLoadedUser extends ProfileState {
  final Profile detail;
  const ProfileStateLoadedUser(this.detail);
  @override
  List<Object> get props => [detail];
}
