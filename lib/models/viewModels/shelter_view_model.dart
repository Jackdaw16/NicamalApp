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

  UserShelterDetail({this.id, this.name, this.image, this.urlDonation, this.history, this.isShelter,
    this.address, this.province, this.country, this.publicationCount, this.urgentCount});

  factory UserShelterDetail.fromJson(Map<String, dynamic> json) {
    return UserShelterDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      urlDonation: json['urlDonation'],
      history: json['history'],
      isShelter: json['isShelter'],
      address: json['address'],
      province: json['province'],
      country: json['country'],
      publicationCount: json['publicationCount'],
      urgentCount: json['urgentCount']
    );
  }
}