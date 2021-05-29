import 'package:nicamal_app/models/viewModels/UserViewModel.dart';

class PublicationsResponseForList {
  var id;
  var name;
  var image;
  var species;
  var gender;
  var personality;
  var createdAt;
  var updatedAt;
  UserForPublication user;

  PublicationsResponseForList(
      {this.id,
      this.name,
      this.image,
      this.species,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory PublicationsResponseForList.fromJson(Map json) {
    return PublicationsResponseForList(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        species: json['species'],
        gender: json['gender'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        user: UserForPublication.fromJson(json['user']));
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

  factory PublicationDetail.fromJson(Map json) {
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
      user: UserForPublicationDetail.fromJson(json['user'])
    );
  }
}
