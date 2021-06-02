import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nicamal_app/io/IServices.dart';
import 'package:nicamal_app/models/viewModels/DisappearanceViewModel.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

class Services extends IServices {
  //Aqui cambiar por tu IP si cambias de maquina
  final String urlDevServer = "https://192.168.1.136:5001/api/";

  @override
  Future<PublicationDetail> getPublication(int id) async {
    var client = Dio();
    var uriParsed = urlDevServer + "publication/detail";
    try {
      final response = await client.get(uriParsed,
          queryParameters: {'id': id})
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The connection has timed out, check your internet connection and try again!');
      });

      return PublicationDetail.fromJson(jsonDecode(json.encode(response.data)));

    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublicationsResponseForList>> getPublications(int page) async {
    var client = Dio();
    var uriParsed = urlDevServer + "publication";
    try {
      final response = await client.get(uriParsed,
          queryParameters: {'pageNumber': page, 'pageSize': 6})
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
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
    var client = Dio();
     var uriParsed = urlDevServer + "publication/filters";
    try {
      final response = await client.get(uriParsed,
          queryParameters: {'pageNumber': page, 'pageSize': 6, 'TextForSearch': text})
          .timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException('The connection has timed out, Please try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<PublicationsResponseForList> publications = iterable.map((model) => PublicationsResponseForList.fromJson(model)).toList();

      return publications;

    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DisappearanceDetail> getDisappearance(int id) async {
    var client = Dio();
    var uriParsed = urlDevServer + "disappearance/detail";
    try {
      final response = await client.get(uriParsed,
          queryParameters: {'id': id})
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The connection has timed out, check your internet connection and try again!');
      });

      return DisappearanceDetail.fromJson(jsonDecode(json.encode(response.data)));

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
      final response = await client.get(uriParsed,
          queryParameters: {'pageNumber': page, 'pageSize': 6})
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The connection has timed out, check your internet connection and try again!');
      });

      Iterable iterable = json.decode(json.encode(response.data));
      List<DisappearanceListResponse> disappearances = iterable.map((model) => DisappearanceListResponse.fromJson(model)).toList();

      return disappearances;

    } on SocketException {
      throw SocketException('You are not connected to internet');
    } catch (e) {
      throw Exception(e);
    }
  }
}
