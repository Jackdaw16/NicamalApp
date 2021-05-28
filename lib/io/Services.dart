import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/retry.dart';
import 'package:nicamal_app/io/IServices.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';
import 'package:http/http.dart' as http;

class Services extends IServices {
  //Aqui cambiar por tu IP si cambias de maquina
  final String urlDevServer = "https://192.168.1.136:5001/api/";

  @override
  Future<PublicationDetail> getPublication(int id) async {
    var uriParsed = Uri.parse(urlDevServer + "publication/" + id.toString());
    final response = await new http.Client().get(uriParsed);

    if (response.statusCode == 200) {
      return PublicationDetail.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else if (response.statusCode == 500) {
      throw Exception('Server Error');
    } else {
      throw Exception('Connection fail');
    }
  }

  @override
  Future<List<PublicationsResponseForList>> getPublications(int page) async {
    var client = http.Client();
    var uriParsed = Uri.parse(urlDevServer + "publication?pageNumber=" + page.toString() +
        "&pageSize=6");
    try {
      final response = await client.get(uriParsed).timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The connection has timed out, check your internet connection and try again!');
      });

      print(response.body);

      Iterable iterable = json.decode(response.body);
      List<PublicationsResponseForList> publications = iterable.map((model) => PublicationsResponseForList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsResponseForList>> getPublicationsWithFilters(int page, String text) async {
    var client = http.Client();
     var uriParsed = Uri.parse(urlDevServer + "publication/filters?pageNumber=" + page.toString() +
        "&pageSize=6&TextForSearch=" + text);
    try {
      final response = await client.get(uriParsed).timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('The connection has timed out, Please try again!');
      });

      print(response.body);

      Iterable iterable = json.decode(response.body);
      List<PublicationsResponseForList> publications = iterable.map((model) => PublicationsResponseForList.fromJson(model)).toList();

      return publications;
    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }


  }
}
