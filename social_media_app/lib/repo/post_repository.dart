import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/util/constants.dart';
import 'dart:convert';

class PostRepository {
  String savePosturl = '/posts';
  String getPosturl = '/posts';

  Future savePost(content, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    dynamic body = {'content': content, 'images': images};
    final respone = await http.post(
      Uri.parse("$apiUrl$savePosturl"),
      body: jsonEncode(body),
      headers: {
        'Content-type': "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return respone;
  }

  Future getAllPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final respone = await http.get(
      Uri.parse("$apiUrl$getPosturl"),
      headers: {
        'Content-type': "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return respone;
  }
}
