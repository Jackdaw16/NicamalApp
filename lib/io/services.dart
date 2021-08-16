import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nicamal_app/io/iservices.dart';
import 'package:nicamal_app/models/Province.dart';
import 'package:nicamal_app/models/viewModels/disappearance_view_model.dart';
import 'package:nicamal_app/models/viewModels/publication_view_model.dart';
import 'package:nicamal_app/models/viewModels/shelter_view_model.dart';
import 'package:nicamal_app/models/viewModels/user_view_model.dart';

class Services extends IServices {
  //Aqui cambiar por tu IP si cambias de maquina
  final String urlDevServer = "https://192.168.1.136:5001/api/";

  @override
  Future<PublicationDetail> getPublication(String id) async {
    var client = Dio();
    var uriParsed = urlDevServer + "publication/detail";
    try {
      final response = await client
          .get(uriParsed, queryParameters: {'id': id}).timeout(
              Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return PublicationDetail.fromJson(jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsList>> getPublications(int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "publication";
    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsList>> getPublicationsWithFilters(
      int page, String text) async {
    var client = Dio();
    var uriParsed = urlDevServer + "publication/filters";
    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'Text': text
      }).timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DisappearanceDetail> getDisappearance(String id) async {
    var client = Dio();
    var uriParsed = urlDevServer + "disappearance/detail";
    try {
      final response = await client
          .get(uriParsed, queryParameters: {'id': id}).timeout(
              Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return DisappearanceDetail.fromJson(
          jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<DisappearanceListResponse>> getDisappearances(int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "disappearance";
    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<DisappearanceListResponse> disappearances = iterable
          .map((model) => DisappearanceListResponse.fromJson(model))
          .toList();

      return disappearances;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DisappearanceDetail> postDisappearance(
      DisappearanceDetail disappearance) async {
    var client = Dio();
    var uriParsed = urlDevServer + "disappearance";

    File file = File(disappearance.image);
    String fileName = file.path.split('/').last;
    print(file.path);

    FormData formData = FormData.fromMap({
      'Name': disappearance.name,
      'Image': await MultipartFile.fromFile(file.path, filename: fileName),
      'TelephoneContact': disappearance.telephoneContact,
      'Description': disappearance.description,
      'Country': disappearance.country,
      'Province': disappearance.province,
      'LastSeen': disappearance.lastSeen,
      'UserName': disappearance.userName
    });
    try {
      final response = await client
          .post(uriParsed, data: formData)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return DisappearanceDetail.fromJson(
          jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Province>> getProvinces() async {
    var client = Dio();
    var uriParsed = urlDevServer + "provinces";

    try {
      final response = await client.get(uriParsed).timeout(Duration(seconds: 5),
          onTimeout: () {
        return null;
      });
      Iterable iterable = json.decode(json.encode(response.data));
      List<Province> provinces =
          iterable.map((model) => Province.fromJson(model)).toList();

      return provinces;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserShelterDetail> getShelter(String id) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/detail";

    try {
      final response = await client
          .get(uriParsed, queryParameters: {'id': id}).timeout(
              Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return UserShelterDetail.fromJson(jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserShelterList>> getShelters(int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6
      }).timeout(Duration(seconds: 5), onTimeout: () {
        return null;
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<UserShelterList> shelters =
          iterable.map((model) => UserShelterList.fromJson(model)).toList();

      return shelters;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<UserShelterList>> getSheltersWithFilters(
      int page, String text) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/filters";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'Text': text
      }).timeout(Duration(seconds: 5), onTimeout: () {
        return null;
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<UserShelterList> shelters =
          iterable.map((model) => UserShelterList.fromJson(model)).toList();

      return shelters;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<PublicationsList>> getShelterPublications(
      String id, int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/publications";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'id': id
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsList>> getShelterPublicationsFilters(
      String id, int page, String text) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/publications/filters";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'id': id,
        'text': text
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsList>> getShelterPublicationsUrgent(
      String id, int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/publications/urgents";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'id': id
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsList>> getShelterPublicationsUrgentFilters(
      String id, int page, String text) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/publications/urgents/filters";

    try {
      final response = await client.get(uriParsed, queryParameters: {
        'page': page,
        'pageSize': 6,
        'id': id,
        'text': text
      }).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsList> publications =
          iterable.map((model) => PublicationsList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserLoggedIn> userLogIn(UserLogIn user) async {
    var client = Dio();
    var uriParsed = urlDevServer + "user/login";

    print(user.email.toString() + user.password.toString());

    try {
      final response = await client
          .post(uriParsed, data: user.toJson(user))
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return UserLoggedIn.fromJson(jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserShelterLoggedIn> userShelterLogIn(UserLogIn user) async {
    var client = Dio();
    var uriParsed = urlDevServer + "shelter/login";

    try {
      final response = await client
          .post(uriParsed, data: user.toJson(user))
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, check your internet connection and try again!');
      });

      return UserShelterLoggedIn.fromJson(
          jsonDecode(json.encode(response.data)));
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }
}
