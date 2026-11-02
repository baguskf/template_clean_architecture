import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/execption.dart';
import '../models/profile_model.dart';

//disini kita buat interface untuk mendefinisikan apa saja yang akan di panggil
abstract class ProfileRemoteData {
  Future<List<ProfileModel>> getAllUser(
    int page,
  ); //pakainya langsung ke profile model, bukan dari entitiy lagi

  Future<ProfileModel> getUserById(int id);
}

//disini kita buat implementasi dari interface
class ProfileRemoteDataImplementation extends ProfileRemoteData {
  final http.Client client;

  ProfileRemoteDataImplementation({required this.client, Object? box});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=$page");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      List<dynamic> data = dataBody['data'];
      return ProfileModel.listFromJson(data);
    } else if (response.statusCode == 404) {
      throw EmptyException("Data not found error code 404");
    } else {
      throw GeneralException("Error Get Data");
    }
    // throw UnimplementedError();
  }

  // "https://reqres.in/api/users/2"

  @override
  Future<ProfileModel> getUserById(int id) async {
    Uri url = Uri.parse("https://reqres.in/api/users/$id");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      Map<String, dynamic> data = dataBody['data'];
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw EmptyException("Data not found error code 404");
    } else {
      throw GeneralException("Error Get Data");
    }
  }
}
