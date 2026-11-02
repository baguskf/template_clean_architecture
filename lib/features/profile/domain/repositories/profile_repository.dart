import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
//repositories adalah kelas abstract

abstract class ProfileRepository {
  //INI TANPA DARTZ (digunakan untuk percabangan sukses atau error)
  // Future<List<Profile>> getAllUser(
  //   int page,
  // ); //kemungkinan ada 2 hasil yaitu success dan error

  //INI MENGGUNAKAN DARTZ
  Future<Either<Failure, List<Profile>>> getAllUser(int page);

  Future<Either<Failure, Profile>> getUserById(int id);
}
