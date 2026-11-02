import 'package:equatable/equatable.dart';

//entitis adalah kelas yang digunakan untuk menyimpan data
//class ini tidak akan parshing json dan pure hanya menyimpan data yang di butuhkan aplikasi

class Profile extends Equatable {
  final int id;
  final String email;
  final String fullName;
  final String avatar;

  const Profile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, email, fullName, avatar];
}
