import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happytobees/pages/Dashboard.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FormulaireAjoutRuche extends StatefulWidget {
  @override
  _FormulaireAjoutRucheState createState() => _FormulaireAjoutRucheState();
}

class _FormulaireAjoutRucheState extends State<FormulaireAjoutRuche> {
  final _formKey = GlobalKey<FormState>();
  String? nomRuche;
  String? photoRuche;
  int? numeroRuche;
  int? nombreCadresCorp;
  int? nombreHausses;
  int? nombreCadresHausse;
  int? nombreCadreCouvain;
  int? nombreCadreNourriture;
  int? nombreCadreLibre;

  Future<void> ajouterRuche() async {
    final url = Uri.parse('http://api.syntaxlab.fr:8001/api/ruches');
    final idApiculteur = Provider.of<AuthProvider>(context, listen: false).userId;

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
      'id_apiculteur': idApiculteur,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rucheData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'ajout de la ruche")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une ruche')),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  "Ajouter une ruche",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ..._buildTextFields(),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD04C03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ajouterRuche();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "AJOUTER",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.add, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField("Nom de la ruche", (value) => nomRuche = value),
      SizedBox(height: 10),
      _buildTextField("Photo (URL)", (value) => photoRuche = value),
      SizedBox(height: 10),
      _buildTextField("Numéro de la ruche", (value) => numeroRuche = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de cadres dans le corps", (value) => nombreCadresCorp = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de hausses", (value) => nombreHausses = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de cadres dans les hausses", (value) => nombreCadresHausse = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de cadres de couvain", (value) => nombreCadreCouvain = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de cadres de nourriture", (value) => nombreCadreNourriture = int.tryParse(value!), isNumeric: true),
      SizedBox(height: 10),
      _buildTextField("Nombre de cadres libres", (value) => nombreCadreLibre = int.tryParse(value!), isNumeric: true),
    ];
  }

  Widget _buildTextField(String label, Function(String?) onSaved, {bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFEBEBE6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFD04C03)),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      onSaved: onSaved,
    );
  }
}