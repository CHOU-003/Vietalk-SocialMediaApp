// ignore: file_names
import 'package:http/http.dart' as http;
import 'package:social_media_app/util/constants.dart';
import 'dart:convert';

class Authrepo {
  String registerUrl = "/auth/register";
  String loginUrl = "/auth/login";

  //For Register
  Future register(username, email, password) async {
    dynamic body = {"username": username, "email": email, "password": password};
    final respone = await http.post(
      Uri.parse("$apiUrl$registerUrl"),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return respone;
  }

  //For Login
  Future login(email, password) async {
    dynamic body = {"email": email, "password": password};
    final respone = await http.post(
      Uri.parse("$apiUrl$loginUrl"),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json', // Example: Setting content type
        'Accept': 'application/json',
      },
    );
    return respone;
  }
}
