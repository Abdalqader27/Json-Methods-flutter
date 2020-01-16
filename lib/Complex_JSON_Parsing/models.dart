class person {
  final String id;
  final String name;
  final String age;
  final List<String> places;
  final List<Images> images;
  final Address address;

  person(
      {this.id, this.name, this.age, this.places, this.images, this.address});

  factory person.fromJson(Map<String, dynamic> json) {
    return person(
        id: json['id'],
        name: json['name'],
        age: json['age'],
//      places: json['places'],
        places: parsePlace(json['place']),
        images: parseImages(json),
        address: Address.fromJson(json['address']));
  }

  static List<String> parsePlace(placeJson) {
    return List<String>.from(placeJson);
  }

  static List<Images> parseImages(imageJson) {
    var list = imageJson['images'] as List;
    List<Images> ImagesList =
        list.map((data) => Images.fromJson(data)).toList();
    return ImagesList;
  }
}

class Images {
  int id;
  String name;

  Images({this.id, this.name});

  factory Images.fromJson(Map<String, dynamic> parsedJson) {
    return Images(id: parsedJson['id'], name: parsedJson['name']);
  }
}

class Details {
  int houseNo;
  String town;

  Details({this.houseNo, this.town});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(houseNo: json['house_no'] as int, town: json['town']);
  }
}

class Address {
  final String streeNo;
  final Details details;

  Address({this.streeNo, this.details});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        streeNo: json['street_no'] as String,
        details: Details.fromJson(json['details']));
  }
}

class Album {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Album({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}
