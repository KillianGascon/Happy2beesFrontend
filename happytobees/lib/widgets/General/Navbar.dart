import 'package:flutter/material.dart';

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
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero, // Supprime le padding interne
                  icon: Icon(
                    Icons.dashboard,
                    color: currentIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => onTap(0),
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero, // Supprime le padding interne
                  icon: Icon(
                    Icons.assignment,
                    color: currentIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => onTap(1),
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.zero, // Supprime le padding interne
                  icon: Icon(
                    Icons.person,
                    color: currentIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => onTap(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}