import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  int _userId = 0; // Utilise un type int pour l'ID utilisateur
  String _token = '';
  String _nomprenom = '';
  String _email = '';

  int get userId => _userId;  // Retourne un int pour l'ID
  String get token => _token;
  String get nomprenom => _nomprenom;
  String get email => _email;

  void setAuthData(int userId, String token, String userMail, String nomprenom) {
    _userId = userId;  // Stocke l'ID en tant qu'int
    _token = token;
    _nomprenom = nomprenom;
    _email = userMail;
    notifyListeners();
  }

  void clearAuthData() {
    _userId = 0;
    _token = '';
    _email = '';
    _nomprenom = '';
    notifyListeners();
  }
}
