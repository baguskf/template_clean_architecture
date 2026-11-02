import 'package:hive_ce/hive_ce.dart';
import '../../../../core/error/execption.dart';

import '../models/profile_model.dart';

//disini kita buat interface untuk mendefinisikan apa saja yang akan di panggil
abstract class ProfileLocalData {
  Future<List<ProfileModel>> getAllUser(
    int page,
  ); //pakainya langsung ke profile model, bukan dari entitiy lagi

  Future<ProfileModel> getUserById(int id);
}

//disini kita buat implementasi dari interface
class ProfileLocalDataImplementation extends ProfileLocalData {
  final Box box;

  ProfileLocalDataImplementation({required this.box});
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var data = box.get('getAllUser');

    if (data == null) throw EmptyException("Data local kosong");
    //box mengembalikan List<dynamic>, jadi perlu di cast ke List<ProfileModel>
    return (data as List).cast<ProfileModel>();
    // throw UnimplementedError();
  }

  // "https://reqres.in/api/users/2"

  @override
  Future<ProfileModel> getUserById(int id) async {
    var data = box.get('getUser');

    if (data == null) throw EmptyException("Data local kosong");
    return data as ProfileModel;
  }
}
