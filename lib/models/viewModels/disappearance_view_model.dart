class DisappearanceListResponse {
  var id;
  var name;
  var image;
  var country;
  var province;
  var description;
  var createdAt;

  DisappearanceListResponse(
      {this.id, this.name, this.image, this.country,
  this.province, this.description, this.createdAt});

  factory DisappearanceListResponse.fromJson(Map json) {
    return DisappearanceListResponse(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        country: json['country'],
        province: json['province'],
        description: json['description'],
        createdAt: json['createdAt']);
  }
}

class DisappearanceDetail {
  var id;
  var name;
  var image;
  var telephoneContact;
  var description;
  var country;
  var province;
  var lastSeen;
  var userName;
  var createdAt;

  DisappearanceDetail(
      {this.id,
      this.name,
      this.image,
      this.telephoneContact,
      this.description,
      this.country,
      this.province,
      this.lastSeen,
        this.userName,
      this.createdAt});

  factory DisappearanceDetail.fromJson(Map json) {
    return DisappearanceDetail(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        telephoneContact: json['telephoneContact'],
        description: json['description'],
        country: json['country'],
        province: json['province'],
        lastSeen: json['lastSeen'],
        userName: json['userName'],
        createdAt: json['createdAt']);
  }
}
