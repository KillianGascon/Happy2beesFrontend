import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final _dateFormatter = MaskTextInputFormatter(mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});

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
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Inscription",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 24),
              ..._buildTextFields(),
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
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value!;
                        });
                      },
                    ),
                  ),
                  Text("J’accepte les termes et conditions"),
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
                  onPressed: _isLoading ? null : _registerUser,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "S'INSCRIRE",
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
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField(_nomController, "Nom"),
      SizedBox(height: 10),
      _buildTextField(_prenomController, "Prénom"),
      SizedBox(height: 10),
      _buildTextField(_emailController, "Email"),
      SizedBox(height: 10),
      _buildTextField(_telephoneController, "Téléphone"),
      SizedBox(height: 10),
      _buildTextField(_numeroApiculteurController, "Numéro apiculteur", isNumeric: true),
      SizedBox(height: 10),
      _buildTextField(_dateNaissanceController, "Date de naissance (YYYY-MM-DD)", isDate: true),
      SizedBox(height: 10),
      _buildTextField(_passwordController, "Mot de passe", isPassword: true),
      SizedBox(height: 10),
      _buildTextField(_confirmPasswordController, "Confirmer le mot de passe", isPassword: true),
    ];
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false, bool isNumeric = false, bool isDate = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isDate ? [_dateFormatter] : null,
      cursorColor: Color(0xFF292927),
      style: TextStyle(color: Colors.black),
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
    );
  }
}