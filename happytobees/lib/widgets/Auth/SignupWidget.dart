import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpWidget extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;
  final int currentPage;

  SignUpWidget({
    required this.pageController,
    required this.onPageChanged,
    required this.currentPage,
  });

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _numeroApiculteurController = TextEditingController();
  final TextEditingController _dateNaissanceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;
  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate() || !_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs et accepter les termes.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String apiUrl = dotenv.env['API_URL']! + '/utilisateurs';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom_apiculteur': _nomController.text,
        'prenom_apiculteur': _prenomController.text,
        'mail': _emailController.text,
        'telephone': _telephoneController.text,
        'numero_apiculteur': int.tryParse(_numeroApiculteurController.text),
        'date_naissance': _dateNaissanceController.text,
        'mot_de_passe': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscription réussie !")),
      );
      widget.pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      widget.onPageChanged(0);
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Erreur inconnue';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: "Nom"),
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(labelText: "Prénom"),
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre prénom" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre email" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _telephoneController,
                decoration: InputDecoration(labelText: "Téléphone"),
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre téléphone" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _numeroApiculteurController,
                decoration: InputDecoration(labelText: "Numéro apiculteur"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre numéro apiculteur" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dateNaissanceController,
                decoration: InputDecoration(labelText: "Date de naissance (YYYY-MM-DD)"),
                validator: (value) => value!.isEmpty ? "Veuillez entrer votre date de naissance" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Mot de passe"),
                obscureText: true,
                validator: (value) => value!.length < 6 ? "Le mot de passe doit contenir au moins 6 caractères" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: "Confirmer le mot de passe"),
                obscureText: true,
                validator: (value) => value != _passwordController.text ? "Les mots de passe ne correspondent pas" : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text("J’accepte les termes et conditions"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  child: Text("S'INSCRIRE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}