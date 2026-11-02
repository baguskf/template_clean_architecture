// ignore_for_file: overridden_fields
// sengaja override field dari Profile supaya bisa diberi @HiveField

import 'package:hive_ce/hive_ce.dart';

import '../../domain/entities/profile.dart';

part 'profile_model.g.dart'; // ini  file yang akan di generate

//untuk parshing json ke model
//profile model ini ber ekstensi ke entitiesnya

@HiveType(typeId: 0)
class ProfileModel extends Profile {
  //id, email, avatar di override di sini supaya @HiveField tidak perlu ditaruh di entity (domain tetap bersih dari hive)
  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @override
  @HiveField(4)
  final String avatar;

  const ProfileModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
         id: id,
         email: email,
         fullName: "$firstName $lastName",
         avatar: avatar,
       );

  //map -> to object ProfileModel
  factory ProfileModel.fromJson(Map<String, dynamic> dataJson) {
    return ProfileModel(
      id: dataJson["id"],
      email: dataJson["email"],
      firstName: dataJson["first_name"],
      lastName: dataJson["last_name"],
      avatar: dataJson["avatar"],
    );
  }

  //ProfileModel -> to Map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
    };
  }

  //List Map -? List<ProfileModel>

  static List<ProfileModel> listFromJson(List dataJson) {
    if (dataJson.isEmpty) return [];
    return dataJson.map((e) => ProfileModel.fromJson(e)).toList();
  }
}
