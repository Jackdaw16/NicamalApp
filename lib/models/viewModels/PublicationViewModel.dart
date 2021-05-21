import 'package:nicamal_app/models/viewModels/UserViewModel.dart';

class PublicationsResponseForList {
  var id;
  var name;
  var image;
  var gender;
  var personality;
  var createdAt;
  var udpatedAt;
  UserForPublication user;

  PublicationsResponseForList(
      {this.id,
      this.name,
      this.image,
      this.gender,
      this.personality,
      this.createdAt,
      this.udpatedAt,
      this.user});

  factory PublicationsResponseForList.fromJson(Map<String, dynamic> json) {
    return PublicationsResponseForList(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        gender: json['personality'],
        createdAt: json['createdAt'],
        udpatedAt: json['updatedAt'],
        user: json['user']);
  }
}

class PublicationDetail {
  var id;
  var name;
  var image;
  var species;
  var weight;
  var gender;
  var personality;
  var history;
  var observation;
  var isUrgent;
  var birthDate;
  var createdAt;
  var updatedAt;
  UserForPublicationDetail user;

  PublicationDetail(
      {this.id,
      this.name,
      this.image,
      this.species,
      this.weight,
      this.gender,
      this.personality,
      this.history,
      this.observation,
      this.isUrgent,
      this.birthDate,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory PublicationDetail.fromJson(Map<String, dynamic> json) {
    return PublicationDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      species: json['species'],
      weight: json['weight'],
      gender: json['gender'],
      personality: json['personality'],
      history: json['history'],
      observation: json['observation'],
      isUrgent: json['isUrgent'],
      birthDate: json['birthDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user']
    );
  }
}
