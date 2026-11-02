import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive_ce.dart';
import '../../../../core/error/failure.dart';
import '../datasources/local_data.dart';
import '../datasources/remote_data.dart';
import '../models/profile_model.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

//dia ber extensi ke profile repository(parentnya) di domain layer
//logic nya di sini
//bisa di gunakan untuk percabangan mau ngambil dari remote atau local
class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteData profileRemoteData;
  final ProfileLocalData profileLocalData;
  final Box box;

  ProfileRepositoryImplementation({
    required this.profileRemoteData,
    required this.profileLocalData,
    required this.box,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> conectivityResult = await Connectivity()
          .checkConnectivity();
      if (conectivityResult.contains(ConnectivityResult.none)) {
        //no internet ambil local
        List<ProfileModel> result = await profileLocalData.getAllUser(page);
        return Right(result);
      } else {
        //ambil remote sekalain add datanya ke local
        List<ProfileModel> result = await profileRemoteData.getAllUser(page);
        // var box = hive.box('profile_box');
        //bisa simpan ProfileModel langsung karena ProfileModelAdapter sudah di register di main
        box.put('getAllUser', result);
        return Right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUserById(int id) async {
    try {
      final List<ConnectivityResult> conectivityResult = await Connectivity()
          .checkConnectivity();
      if (conectivityResult.contains(ConnectivityResult.none)) {
        //no internet ambil local
        ProfileModel result = await profileLocalData.getUserById(id);
        return Right(result);
      } else {
        //ambil remote sekalain add datanya ke local
        ProfileModel result = await profileRemoteData.getUserById(id);
        // var box = hive.box('profile_box');
        box.put('getUser', result);
        return Right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
