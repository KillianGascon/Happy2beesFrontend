import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _rememberMe = false;
  bool _obscurePassword = true; // Variable pour gérer l'état du mot de passe


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          _buildLoginWidget(), // Page de connexion
          _buildSignUpPage(),  // Page d'inscription
        ],
      ),
    );
  }

  Widget _buildLoginWidget() {
    return Container(
      margin: EdgeInsets.all(20), // Marge externe de 20px
      padding: EdgeInsets.all(20), // Espacement interne
      decoration: BoxDecoration(
        color: Colors.white, // Couleur de fond blanche
        borderRadius: BorderRadius.circular(32), // Bord arrondi
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Ombre légère
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Hauteur réduite
                    decoration: BoxDecoration(
                      gradient: _currentPage == 0
                          ? LinearGradient(
                        colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)], // Dégradé
                        begin: Alignment.bottomLeft, // Départ du dégradé
                        end: Alignment.topRight, // Fin du dégradé
                      )
                          : null,
                      color: _currentPage != 0 ? Colors.transparent : null,
                      borderRadius: BorderRadius.circular(360), // Bord arrondi
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _currentPage = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _currentPage == 1
                          ? Color(0xFFD04C03)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 1 ? Colors.white : Colors.black,
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
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 24),
          TextField(
            cursorColor: Color(0xFF292927),
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: "Email",
              floatingLabelStyle: TextStyle(
                color: Color(0xFF292927),
              ),
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
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(
                color: Color(0xFF292927),
              ),
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
                  _obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
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
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Color(0xFFD04C03),
                ),
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
              onPressed: () {
                // Action pour se connecter
              },
              child: Row(
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
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            child: Text("Pas encore inscrit ? Inscrivez-vous"),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpPage() {
    return Container(
      margin: EdgeInsets.all(20), // Marge externe
      padding: EdgeInsets.all(20), // Espacement interne
      decoration: BoxDecoration(
        color: Colors.white, // Couleur de fond blanche
        borderRadius: BorderRadius.circular(32), // Bord arrondi
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Ombre légère
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: _currentPage == 0
                          ? LinearGradient(
                        colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )
                          : null,
                      color: _currentPage != 0 ? Colors.transparent : null,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    setState(() {
                      _currentPage = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: _currentPage == 1
                          ? LinearGradient(
                        colors: [Color(0xFFD04C03), Color(0xFFEBCF8D)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )
                          : null,
                      color: _currentPage != 1 ? Colors.transparent : null,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirmer le mot de passe",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD04C03),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // Action pour soumettre le formulaire d'inscription
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
                _pageController.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
                setState(() {
                  _currentPage = 0;
                });
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
    );
  }
}