import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart' as http;
import 'package:template_clean_architecture/features/profile/profile_injection.dart';

import 'features/profile/data/models/profile_model.dart';

var appInjection =
    GetIt.instance; //ini adalah tempat penampungan semua dependency

//function ini akan di gunakan untuk inject semua dependency
Future<void> init() async {
  //General Dependency
  //hive
  Hive.registerAdapter(ProfileModelAdapter());
  //box harus dibuka dulu sebelum hive.box() dipakai
  var box = await Hive.openBox('profile_box');
  appInjection.registerLazySingleton(() => box);

  //http

  appInjection.registerLazySingleton(() => http.Client());

  //Feature -> Profile
  initProfileInjection();
}
