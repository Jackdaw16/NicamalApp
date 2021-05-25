import 'dart:convert';

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
    var uriParsed = Uri.parse(urlDevServer + "publication?pageNumber=" + page.toString() +
        "&pageSize=6");
    final response = await new http.Client().get(uriParsed);

    if (response.statusCode == 200) {
      print(response.body);

      Iterable iterable = json.decode(response.body);
      List<PublicationsResponseForList> publications = iterable.map((model) => PublicationsResponseForList.fromJson(model)).toList();

      return publications;
    } else {
      throw Exception('Failed to connect with server');
    }
  }
}
