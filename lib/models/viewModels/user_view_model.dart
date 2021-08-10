import 'dart:convert';

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

class UserLogIn {
  var email;
  var password;

  UserLogIn({this.email, this.password});

  factory UserLogIn.fromJson(Map<String, dynamic> json) {
    return UserLogIn(
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson(UserLogIn user) {
    return <String, dynamic> {
      'email': user.email,
      'password': user.password
    };
  }
}

class UserResponseWhenLoggedIn {
  var id;
  var name;
  var surName;
  var email;
  var image;
  var telephoneContact;
  var country;
  var province;
  var address;
  var isShelter;
  var createdAt;

  UserResponseWhenLoggedIn({this.id, this.name, this.surName, this.email, this.image, this.telephoneContact, this.country, this.province, this.address, this.isShelter, this.createdAt});

  factory UserResponseWhenLoggedIn.fromJson(Map<String, dynamic> json) {
    return UserResponseWhenLoggedIn(
      id: json['id'],
      name: json['name'],
      surName: json['surName'],
      email: json['email'],
      image: json['image'],
      telephoneContact: json['telephoneContact'],
      country: json['country'],
      province: json['province'],
      address: json['address'],
      isShelter: json['isShelter'],
      createdAt: json['createdAt']
    );
  }

}

class UserLoggedIn {
  UserResponseWhenLoggedIn userResponse;
  String token;

  UserLoggedIn({this.userResponse, this.token});

  factory UserLoggedIn.fromJson(Map<String, dynamic> json) {
    return UserLoggedIn(
      userResponse: UserResponseWhenLoggedIn.fromJson(json['userResponse']),
      token: json['token']
    );
  }
}
