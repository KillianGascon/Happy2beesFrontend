import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:happytobees/pages/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:happytobees/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  LoginWidget({required this.pageController, required this.onPageChanged});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://api.syntaxlab.fr:8001/api/utilisateurs/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur : La réponse de l'API est vide")),
          );
          return;
        }

        print("Réponse de l'API : ${response.body}");  // Afficher le corps de la réponse

        final responseBody = jsonDecode(response.body);
        print("Réponse JSON : $responseBody");  // Vérifie le contenu de la réponse JSON

        if (responseBody['message'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur : ${responseBody['message']}")),
          );
        } else {
          final user = responseBody['user'];  // Récupère l'objet 'user'
          final userId = user['id'];  // Accède à l'ID de l'utilisateur à partir de 'user'
          final userMail = user['mail'];  // Récupère l'email de l'utilisateur
          // Récupère le nom et prenom de l'apiculteur et les concatène
          final nomprenom = "${user['nom_apiculteur']} ${user['prenom_apiculteur']}";
          final token = responseBody['token'];  // Récupère le token

          print("ID de l'utilisateur : $userId");  // Affiche l'ID de l'utilisateur
          print("Email de l'utilisateur : $userMail");  // Affiche l'email de l'utilisateur
          print("Nom et prénom de l'apiculteur : $nomprenom");  // Affiche le nom et prénom
          print("Token : $token");  // Affiche le token pour vérifier sa présence

          if (userId != null && token != null) {
            Provider.of<AuthProvider>(context, listen: false).setAuthData(userId, token, userMail, nomprenom);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Connexion réussie !")),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Erreur : ID ou token manquant")),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : Code de statut ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur de connexion : $e")),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      widget.onPageChanged(0);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      widget.pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      widget.onPageChanged(1);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Login",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 24),
            TextField(
              controller: _emailController,
              cursorColor: Color(0xFF292927),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Email",
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
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _passwordController,
              cursorColor: Color(0xFF292927),
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
                labelText: "Mot de passe",
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
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(unselectedWidgetColor: Color(0xFFD04C03)),
                  child: Checkbox(
                    activeColor: Color(0xFFD04C03),
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                ),
                Text("Se souvenir de moi"),
              ],
            ),
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
                onPressed: _isLoading ? null : _login,
                child:
                _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SE CONNECTER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  widget.onPageChanged(1);
                },
                child: Text(
                  "Déjà inscrit ? Connectez-vous",
                  style: TextStyle(
                    color: Color(0xFFD04C03),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
