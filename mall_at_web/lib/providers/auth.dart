import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _userId;
  DateTime _expiryDate;
  String _token;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAY8ZWJtI9sd8qhh-E_bxw8EehMQvKcsRU';
    try {
      await _authenticate(email, password, url);
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAY8ZWJtI9sd8qhh-E_bxw8EehMQvKcsRU';
    try {
      await _authenticate(email, password, url);
    } catch (error) {
      throw error;
    }
  }

  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await http.post(
        url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}),
      );
      if (json.decode(response.body)['error'] != null)
        throw Exception('Error:' +
            json.decode(response.body)['error']['message'].toString());
      _token = json.decode(response.body)['idToken'];
      _userId = json.decode(response.body)['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            json.decode(
              response.body,
            )['expiresIn'],
          ),
        ),
      );
      _autoLogOut();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void logOut() {
    _userId = null;
    _token = null;
    _expiryDate = null;
    if(_authTimer!=null){
      _authTimer.cancel();
      _authTimer=null;
    }
    notifyListeners();
  }

  void _autoLogOut() {
//    if (_authTimer != null) _authTimer = null;
//    final timeToExpiry = _expiryDate.difference(DateTime.now());
//    _authTimer = Timer(Duration(seconds: 3), logOut);
  }
}
