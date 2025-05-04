import 'package:flutter/material.dart';
import 'package:happytobees/pages/Profile/ProfilePage.dart';
import 'package:happytobees/pages/HomePage.dart';
import 'package:happytobees/pages/Dashboard.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 358, // Largeur spécifiée
        height: 56, // Hauteur spécifiée
        decoration: BoxDecoration(
          color: const Color(0xFF090E2D),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).toInt()), // Conversion de l'opacité en alpha
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                  );
                },
                child: Container(
                  color: Colors.transparent, // Zone cliquable transparente
                  child: Center(
                    child: Icon(
                      Icons.assignment,
                      color: currentIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                child: Container(
                  color: Colors.transparent, // Zone cliquable transparente
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: currentIndex == 2 ? Colors.blue : Colors.grey,
                    ),
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