import 'package:nicamal_app/models/viewModels/user_view_model.dart';

class PublicationsList {
  var id;
  var name;
  var image;
  var species;
  var gender;
  var createdAt;
  var updatedAt;
  UserForPublication user;

  PublicationsList(
      {this.id,
      this.name,
      this.image,
      this.species,
      this.gender,
      this.createdAt,
      this.updatedAt,
      this.user});

  factory PublicationsList.fromJson(Map json) {
    return PublicationsList(
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
  var age;
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
      this.age,
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
      observation: json['observations'],
      isUrgent: json['isUrgent'],
      age: json['age'],
      createdAt: json['createdAt'],
      updatedAt: json['updateAt'],
      user: UserForPublicationDetail.fromJson(json['user'])
    );
  }
}
