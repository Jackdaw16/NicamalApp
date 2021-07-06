class UserForPublication {
  var id;
  var address;
  var province;
  var country;

  UserForPublication({this.id, this.address, this.province, this.country});

  factory UserForPublication.fromJson(Map<String, dynamic> json) {
    return UserForPublication(
        id: json['id'],
        address: json['address'],
        province: json['province'],
        country: json['country']);
  }
}

class UserForPublicationDetail {
  var id;
  var name;
  var image;
  var country;
  var province;
  var address;
  var isShelter;
  var createdAt;

  UserForPublicationDetail(
      {this.id,
      this.name,
      this.image,
      this.country,
      this.province,
      this.address,
      this.isShelter,
      this.createdAt});
  
  factory UserForPublicationDetail.fromJson(Map<String, dynamic> json) {
    return UserForPublicationDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      country: json['country'],
      province: json['province'],
      address: json['address'],
      isShelter: json['isShelter'],
      createdAt: json['createdAt']
    );
  }
}
