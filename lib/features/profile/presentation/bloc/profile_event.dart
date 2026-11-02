part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileEventGetAllUsers extends ProfileEvent {
  final int page;
  ProfileEventGetAllUsers({required this.page});
  @override
  List<Object?> get props => [page];
}

class ProfileEventGetDetaillUsers extends ProfileEvent {
  final int userId;
  ProfileEventGetDetaillUsers({required this.userId});
  @override
  List<Object?> get props => [userId];
}
