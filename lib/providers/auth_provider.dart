import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD0ofo-SG8AVOZxPHTP_HLL-vIY0h4MDAY";
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
  }
}
