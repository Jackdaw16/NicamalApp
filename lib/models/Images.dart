class Images {
  var image;

  Images({this.image});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(image: json['image']);
  }
}
