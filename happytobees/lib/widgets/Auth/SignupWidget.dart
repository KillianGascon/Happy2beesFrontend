import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:happytobees/pages/Auth/TermsAndConditionsPage.dart';

class SignUpWidget extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;
  final int currentPage; // Ajout du paramètre

  SignUpWidget({
    required this.pageController,
    required this.onPageChanged,
    required this.currentPage, // Initialisation
  });

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _acceptTerms = false;

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
                    widget.pageController.animateToPage(0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    widget.onPageChanged(0);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: widget.currentPage == 0
                          ? LinearGradient(
                        colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )
                          : null,
                      color: widget.currentPage != 0 ? Colors.transparent : null,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.currentPage == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    widget.pageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    widget.onPageChanged(1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: widget.currentPage == 1
                          ? LinearGradient(
                        colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )
                          : null,
                      color: widget.currentPage != 1 ? Colors.transparent : null,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.currentPage == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: Color(0xFF292927),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
                    labelText: "Nom",
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
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  cursorColor: Color(0xFF292927),
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
                    labelText: "Prénom",
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
              ),
            ],
          ),
          SizedBox(height: 24),
          TextField(
            cursorColor: Color(0xFF292927),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
              labelText: "Numéro apiculteur",
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
            cursorColor: Color(0xFF292927),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
              labelText: "Email",
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
            cursorColor: Color(0xFF292927),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
              labelText: "Téléphone",
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
            cursorColor: Color(0xFF292927),
            style: TextStyle(color: Colors.black),
            obscureText: true,
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
            ),
          ),
          SizedBox(height: 24),
          TextField(
            cursorColor: Color(0xFF292927),
            style: TextStyle(color: Colors.black),
            obscureText: true,
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: Color(0xFF292927)),
              labelText: "Confirmer le mot de passe",
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
          Row(
            children: [
              Checkbox(
                activeColor: Color(0xFFD04C03),
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value!;
                  });
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "J’accepte les ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "termes et conditions",
                        style: TextStyle(
                          color: Color(0xFFD04C03),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Naviguer vers la page Termes et Conditions
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsAndConditionsPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
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
              onPressed: () {
                // Redirige vers la page de connexion
                widget.pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                widget.onPageChanged(0);
              },
              child: Text(
                "S'INSCRIRE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                widget.pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                widget.onPageChanged(0);
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
