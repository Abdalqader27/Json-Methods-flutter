import 'dart:convert';

import 'package:http/http.dart' as http;

class Urls {
  static const BASE_API_URL = "https://jsonplaceholder.typicode.com";
}

class ApiService {
  static Future<dynamic> _get(String url) async {
    final respnose = await http.get(url);
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

  static Future<List<dynamic>> getPostList() async {
    final respnose = await http.get('${Urls.BASE_API_URL}/posts');
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

  static Future<dynamic> getPost(int postId) async {
    return await _get('${Urls.BASE_API_URL}/posts/$postId');
  }

  static Future<List<dynamic>> getCommentForPost(int postId) async {
    return await _get('${Urls.BASE_API_URL}/posts/$postId/comments');
  }

  static Future<dynamic> getCommentForPosts(int postId) async {
    final respnose =
        await http.get('${Urls.BASE_API_URL}/posts/$postId/comments');
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
