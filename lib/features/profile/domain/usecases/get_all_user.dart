//Usecase untuk get all users

import 'package:dartz/dartz.dart';
import 'package:template_clean_architecture/core/error/failure.dart';
import 'package:template_clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:template_clean_architecture/features/profile/domain/repositories/profile_repository.dart';

class GetAllUsers {
  final ProfileRepository profileRepository;

  const GetAllUsers(this.profileRepository);

  //ini akan ngambil dari repository
  Future<Either<Failure, List<Profile>>> execute(int page) async {
    return await profileRepository.getAllUser(page);
  }
}
