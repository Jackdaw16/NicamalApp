class Province {
  var name;

  Province({this.name});

  factory Province.fromJson(Map json) {
    return Province(
      name: json['name']
    );
  }
}