import 'package:dto_flutter_learning_f_captain/Complex_JSON_Parsing/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JsonDemoState();
  }
}

class JsonDemoState extends State<JsonDemo> {
  Future<String> loadPersonFromAssets() async {
    return await rootBundle.loadString('json/person.json');
  }

  Future<String> loadPerson() async {
//    String jsonString = await loadPersonFromAssets();
//    final jsonResponse = json.decode(jsonString);
//    person Objector = new person.fromJson(jsonResponse);
//    print('Name ${Objector.name}');
//    print('Places ${Objector.places}');
//    print('Images ${Objector.images[0]}');
//    print('Address ${Objector.address.details.town}');
    print('Loading..... ');
    Services.getPhotos().then((album) {
      //    print(album.length);
      print(album[1].title);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPerson();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(),
    );
  }
}
