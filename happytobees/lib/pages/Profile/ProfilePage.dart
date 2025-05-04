import 'package:flutter/material.dart';
import 'package:happytobees/pages/HomePage.dart';
import 'package:happytobees/pages/Profile/ProfileDetailPage.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:happytobees/widgets/General/Navbar.dart';
import 'package:provider/provider.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Détection du tap ici
      child: Container(
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
                Container(
                  width: 100, // Diamètre du cercle
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.purple[100], // Couleur de fond
                    shape: BoxShape.circle, // Forme circulaire
                  ),
                ),
                const SizedBox(height: 16),
                // Nom et Email
                Text(
                  // Remplacer par l'email de l'utilisateur stocké dans le provider
                  '${Provider.of<AuthProvider>(context).nomprenom}',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  // Remplacer par l'email de l'utilisateur stocké dans le provider
                  '${Provider.of<AuthProvider>(context).email}',
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
              children: [
                ProfileOption(
                  icon: Icons.person,
                  title: 'Profile details',
                  onTap: () {
                    print("Redirection vers ProfileDetailPage...");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailPage(),
                      ),
                    );
                  },
                ),
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Ajouter la logique pour Settings ici
                  },
                ),
                ProfileOption(
                  icon: Icons.support_agent,
                  title: 'Support',
                  onTap: () {
                    // Ajouter la logique pour Support ici
                  },
                ),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Récupérer l'instance du AuthProvider et appeler la méthode clearAuthData pour effacer les données d'authentification
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    authProvider.clearAuthData();  // Efface les données d'authentification

                    // Rediriger vers la page de login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),  // Remplace LoginPage() par le widget de votre page de login
                    );
                  },
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
