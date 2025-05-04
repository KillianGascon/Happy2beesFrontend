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

    final url = Uri.parse(
        'http://api.syntaxlab.fr:8001/api/utilisateurs/$userId');

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
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _userDetails.isEmpty
          ? Center(child: Text('Impossible de charger les données utilisateur'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centre l'avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple[100],
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nom: ${_userDetails['nom_apiculteur'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Prénom: ${_userDetails['prenom_apiculteur'] ??
                  'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${_userDetails['mail'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Téléphone: ${_userDetails['telephone'] ?? 'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Numéro Apiculteur: ${_userDetails['numero_apiculteur'] ??
                  'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Date de Naissance: ${_userDetails['date_naissance'] ??
                  'Non disponible'}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}