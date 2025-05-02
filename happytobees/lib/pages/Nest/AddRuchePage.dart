import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happytobees/pages/Dashboard.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:happytobees/widgets/nest/ruche.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FormulaireAjoutRuche extends StatefulWidget {
  @override
  _FormulaireAjoutRucheState createState() => _FormulaireAjoutRucheState();
}

class _FormulaireAjoutRucheState extends State<FormulaireAjoutRuche> {
  final _formKey = GlobalKey<FormState>();
  int? idApiculteur;
  String? photoRuche;
  int? numeroRuche;
  String? nomRuche;
  int? nombreCadresCorp;
  int? nombreHausses;
  int? nombreCadresHausse;
  int? nombreCadreCouvain;
  int? nombreCadreNourriture;
  int? nombreCadreLibre;

  Future<void> ajouterRuche() async {
    final url = Uri.parse('http://api.syntaxlab.fr:8001/api/ruches');

    // Récupérer l'ID de l'apiculteur à partir du AuthProvider
    final idApiculteur = Provider.of<AuthProvider>(context, listen: false).userId;

    // Renommage des clés JSON en snake_case pour correspondre à Rust
    final rucheData = {
      'nom_ruche': nomRuche,
      'photo_ruche': photoRuche,
      'numero_ruche': numeroRuche,
      'nombre_cadres_corp': nombreCadresCorp,
      'nombre_hausses': nombreHausses,
      'nombre_cadres_hausse': nombreCadresHausse,
      'nombre_cadre_couvain': nombreCadreCouvain,
      'nombre_cadre_nourriture': nombreCadreNourriture,
      'nombre_cadre_libre': nombreCadreLibre,
      'id_apiculteur': idApiculteur,  // Ajout de l'ID de l'apiculteur
    };

    print('Données envoyées : $rucheData');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(rucheData),
    );

    print('Code réponse : ${response.statusCode}');
    print('Body réponse : ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Ruche ajoutée avec succès');

      // Redirection vers le dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
      // Remplacez '/dashboard' par le nom de la route de votre dashboard
    } else {
      print('Erreur lors de l\'ajout de la ruche');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une ruche')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom de la ruche'),
                onSaved: (value) => nomRuche = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Photo (URL)'),
                onSaved: (value) => photoRuche = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Numéro de la ruche'),
                keyboardType: TextInputType.number,
                onSaved: (value) => numeroRuche = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de cadres dans le corps'),
                keyboardType: TextInputType.number,
                onSaved: (value) => nombreCadresCorp = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de hausses'),
                keyboardType: TextInputType.number,
                onSaved: (value) => nombreHausses = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de cadres dans les hausses'),
                keyboardType: TextInputType.number,
                onSaved: (value) => nombreCadresHausse = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de cadres de couvain'),
                keyboardType: TextInputType.number,
                onSaved: (value) => nombreCadreCouvain = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de cadres de nourriture'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                nombreCadreNourriture = int.tryParse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre de cadres libres'),
                keyboardType: TextInputType.number,
                onSaved: (value) => nombreCadreLibre = int.tryParse(value!),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ajouterRuche();
                  }
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
