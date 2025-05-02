import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  bool _isLoading = true;
  Map<String, dynamic> _userDetails = {};

  // Fonction pour appeler l'API et récupérer les données utilisateur
  Future<void> _fetchUserDetails() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;

    final url = Uri.parse('http://api.syntaxlab.fr:8001/utilisateurs/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _userDetails = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print("Erreur lors de la récupération des données utilisateur");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Erreur: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Profil'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom: ${_userDetails['user']?['nom_apiculteur'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Prénom: ${_userDetails['user']?['prenom_apiculteur'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${_userDetails['user']?['mail'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Téléphone: ${_userDetails['user']?['telephone'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Numéro Apiculteur: ${_userDetails['user']?['numero_apiculteur'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Date de Naissance: ${_userDetails['user']?['date_naissance'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
