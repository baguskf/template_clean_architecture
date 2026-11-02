import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_all_user.dart';
import '../../domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUsers getAllUsers;
  final GetUser getUserById;

  ProfileBloc({required this.getAllUsers, required this.getUserById})
    : super(ProfileStateEmpty()) {
    // on<ProfileEvent>((event, emit) {});
    on<ProfileEventGetAllUsers>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, List<Profile>> result = await getAllUsers.execute(
        event.page,
      );

      result.fold(
        (left) {
          emit(ProfileStateError('Cannot Get All User'));
        },
        (right) {
          emit(ProfileStateLoadedAllUsers(right));
        },
      );
    });
    on<ProfileEventGetDetaillUsers>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, Profile> result = await getUserById.execute(event.userId);

      result.fold(
        (left) {
          emit(ProfileStateError('Cannot Get All User'));
        },
        (right) {
          emit(ProfileStateLoadedUser(right));
        },
      );
    });
  }
}
