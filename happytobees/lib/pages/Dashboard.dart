import 'package:flutter/material.dart';
import 'package:happytobees/pages/Nest/NestPage.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:happytobees/widgets/General/Navbar.dart';
import 'package:happytobees/widgets/nest/ruche.dart';
import 'package:happytobees/API/ruche_service.dart';
import 'package:happytobees/pages/Nest/AddRuchePage.dart';
import 'package:provider/provider.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<void> _loadFuture;
  List<Ruche> ruches = [];
  final RucheService rucheService = RucheService();

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadRuches();
  }

  Future<void> _loadRuches() async {
    int? utilisateurId = await _getUtilisateurConnecteId(context);

    if (utilisateurId != null) {
      try {
        List<Ruche> fetchedRuches = await rucheService.fetchRuches(utilisateurId);
        setState(() {
          ruches = fetchedRuches;
        });
      } catch (e) {
        setState(() {
          ruches = [];
        });
        print('Erreur lors de la récupération des ruches: $e');
      }
    } else {
      setState(() {
        ruches = [];
      });
    }
  }

  Future<int?> _getUtilisateurConnecteId(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simule un délai

    // Accède à l'instance du AuthProvider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return authProvider.userId; // Retourne l'ID de l'utilisateur
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Mon Dash'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
            // Navigue vers la page de l'ajout de ruche
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => FormulaireAjoutRuche(),
                ),
              );
            }
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            // Si aucune ruche n'est trouvée, on affiche un message
            if (ruches.isEmpty) {
              return const Center(child: Text('Aucune ruche trouvée.'));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mes ruches',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: ruches.map((ruche) {
                        return DashboardCard(
                          title: ruche.nomRuche ?? 'Nom non défini',
                          subtitle: '${(ruche.nombreCadresCorp ?? 0) + (ruche.nombreCadresHausse ?? 0)} cadres',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NestPage(ruche: ruche),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: 0,
        onTap: (index) {
          print('Onglet sélectionné : $index');
        },
      ),
    );
  }
}