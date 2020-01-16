import 'dart:convert';

import 'package:http/http.dart' as http;

class Urls {
  static const BASE_API_URL = "https://jsonplaceholder.typicode.com";
}

class ApiService {
  static Future<List<dynamic>> getUserList() async {
    final respnose = await http.get('${Urls.BASE_API_URL}/users');
    try {
      if (respnose.statusCode == 200) {
        return json.decode(respnose.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
