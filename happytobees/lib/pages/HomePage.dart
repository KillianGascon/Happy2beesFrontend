import 'package:flutter/material.dart';
import 'package:happytobees/pages/Auth/AuthPage.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Section
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            color: Color(0xFF2D2F41), // Dark blue color for the header
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.wifi, // Replace with a custom logo if needed
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Logo Section
          Transform.translate(
            offset: Offset(0, -40), // Move the logo upwards
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF34D399), // Light green background
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi, // Replace with your desired icon/logo
                size: 40,
                color: Colors.black,
              ),
            ),
          ),

          // Title and Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Happy 2 Bee",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Gestionnaire de rucher",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          // Get Started Button
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF34D399), // Light green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // Naviguer vers la page de connexion après avoir cliqué sur le bouton "Get Started"
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: Text(
                "GET STARTED",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}