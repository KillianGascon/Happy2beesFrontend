import 'package:flutter/material.dart';
import 'package:happytobees/widgets/General/Navbar.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const DashboardCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Icon(Icons.cable, size: 40),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class DashboardListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const DashboardListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Supprime la flèche de retour
        title: const Text('Mon Dash'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section "Mes ruches"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mes ruches',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardCard(title: 'Ruche 1', subtitle: 'X Cadres'),
                      DashboardCard(title: 'Ruche 2', subtitle: 'X Cadres'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      DashboardCard(title: 'Ruche 3', subtitle: 'X Cadres'),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            // Section "Mes interventions"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mes Interventions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(
                      4,
                          (index) => const DashboardListTile(
                        title: 'Intervention',
                        subtitle: 'Intervention sur les cadres',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 0, // Indique l'onglet actuellement sélectionné
        onTap: (index) {
          // Logique de navigation entre les onglets
          print('Onglet sélectionné : $index');
        },
      ),
    );
  }
}
