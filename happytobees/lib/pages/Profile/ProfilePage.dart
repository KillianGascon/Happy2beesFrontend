import 'package:flutter/material.dart';
import 'package:happytobees/widgets/General/Navbar.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Section Profil
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const NetworkImage(
                    'https://via.placeholder.com/150', // Remplacez par l'URL de votre image
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Nom et Email
                const Text(
                  'Ruben Geidt',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ruben.geidt@example.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
          // Section Options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ProfileOption(
                  icon: Icons.person,
                  title: 'Profile details',
                ),
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                ),
                ProfileOption(
                  icon: Icons.support_agent,
                  title: 'Support',
                ),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 2, // Indique que l'onglet "Profil" est sélectionné
        onTap: (index) {
          // Logique de navigation entre les onglets
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/interventions');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}