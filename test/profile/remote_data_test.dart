//MOCK ->profile remote data
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:template_clean_architecture/core/error/execption.dart';
import 'package:template_clean_architecture/features/profile/data/datasources/remote_data.dart';
import 'package:template_clean_architecture/features/profile/data/models/profile_model.dart';

// Annotation which generates the cat_test.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<ProfileRemoteData>(), MockSpec<http.Client>()])
import 'remote_data_test.mocks.dart';

void main() async {
  // Create mock object.

  MockClient mockClient = MockClient();
  var remoteData = MockProfileRemoteData();
  var remoteDataImplementation = ProfileRemoteDataImplementation(
    client: mockClient,
  ); //client nya yang akan di fake

  const int userId = 1;
  const int page = 1;

  // Uri urlAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users/$userId");

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "bagusprogrammer@gmail.com",
    "first_name": "bagus karunia",
    "last_name": "fajar",
    "avatar": "https://image.com/$userId",
  };

  final ProfileModel fakeProfileModel = ProfileModel(
    id: userId,
    email: "bagusprogrammer@gmail.com",
    firstName: "bagus karunia",
    lastName: "fajar",
    avatar: "https://image.com/$userId",
  );

  //Group di bawah adalah testing abstrac class
  group('Profile Remote Data', () {
    group('getUserById()', () {
      test('BERHASIL', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(
          remoteData.getUserById(userId),
        ).thenAnswer((_) async => fakeProfileModel);

        try {
          var response = await remoteData.getUserById(userId);
          expect(response, fakeProfileModel);
          // TESTING KEBERHASILAN MOCK
        } catch (e) {
          fail('Tidak mungkin terjadi error');
        }
      });

      test('GAGAL', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(remoteData.getUserById(userId)).thenThrow(Exception());

        try {
          // var response = await remoteData.getUserById(userId);
          fail('Tidak mungkin terjadi error');
          // TESTING KEBERHASILAN MOCK
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group('getAllUser()', () {
      test('BERHASIL', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(
          remoteData.getAllUser(page),
        ).thenAnswer((_) async => [fakeProfileModel]);

        try {
          var response = await remoteData.getAllUser(page);
          expect(response, [fakeProfileModel]);
          // TESTING KEBERHASILAN MOCK
        } catch (e) {
          fail('Tidak mungkin terjadi error');
        }
      });

      test('GAGAL', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(remoteData.getAllUser(page)).thenThrow(Exception());

        try {
          // var response = await remoteData.getAllUser(page);
          fail('Tidak mungkin terjadi error');
          // TESTING KEBERHASILAN MOCK
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });

  group("Profile Remote Data Implementation", () {
    group('getUserById()', () {
      test('BERHASIL (200)', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(mockClient.get(urlGetUser)).thenAnswer(
          (_) async => http.Response(jsonEncode({"data": fakeDataJson}), 200),
        );

        try {
          var response = await remoteDataImplementation.getUserById(userId);
          expect(response, fakeProfileModel);
          // TESTING KEBERHASILAN MOCK
        } catch (e) {
          fail('Tidak mungkin terjadi error');
        }
      });

      test('GAGAL 404', () async {
        //stub -> kondisi untuk memalsukan data
        //di bawah ini adalah proses stubing
        when(
          mockClient.get(urlGetUser),
        ).thenThrow(EmptyException("Data not found error code 404"));

        try {
          // var response = await remoteDataImplementation.getUserById(userId);
          // TESTING KEBERHASILAN MOCK
          fail('Tidak mungkin terjadi error');
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });
}
