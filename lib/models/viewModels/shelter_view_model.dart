class UserShelterList {
  var id;
  var name;
  var image;
  var address;
  var province;
  var country;
  var publicationCount;

  UserShelterList(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.province,
      this.country,
      this.publicationCount});

  factory UserShelterList.fromJson(Map<String, dynamic> json) {
    return UserShelterList(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        address: json['address'],
        province: json['province'],
        country: json['country'],
        publicationCount: json['publicationCount']);
  }
}

class UserShelterDetail {
  var id;
  var name;
  var image;
  var urlDonation;
  var history;
  var isShelter;
  var address;
  var province;
  var country;
  var publicationCount;
  var urgentCount;
}