import 'package:flutter/material.dart';
import 'package:happytobees/pages/Dashboard.dart';
import 'package:happytobees/widgets/nest/ruche.dart';

class NestPage extends StatelessWidget {
  final Ruche ruche;

  const NestPage({Key? key, required this.ruche}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${ruche.nomRuche ?? "Nom inconnu"}'), // Utiliser une valeur par défaut si nomRuche est null
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // todo: Ajouter une image de la ruche
            // Afficher l'image de la ruche si elle existe sinon afficher juste un rectangle
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ruche.photoRuche != null
                  ? Image.network(ruche.photoRuche!, fit: BoxFit.cover)
                  : const Center(child: Text('Aucune image disponible')),
            ),
            const SizedBox(height: 16),
            Text(
              'Nombre de cadres total : ${((ruche.nombreCadresCorp ?? 0) + (ruche.nombreCadresHausse ?? 0))}', // Additionner les cadres du corps et des hausses
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Nombre de cadres dans le corps : ${ruche.nombreCadresCorp ?? 0}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Nombre de cadres dans la / les hausses : ${ruche.nombreCadresHausse ?? 0}',
              style: const TextStyle(fontSize: 16),
            ),
            // todo: Gérer le poids de la ruche
            const SizedBox(height: 8),
            // todo: afficher la force de la ruche en fonction du poid, du nombre de cadres dans le corps et du nombre de cadres dans la hausse et de la saison
            // Titre de la section matériel
            const Text(
              'Matériel :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // todo: Afficher le matériel de la ruche
            // Si le matériel est vide, afficher un boutton d'ajout

            const SizedBox(height: 8),
            const Text(
              'Mes Interventions :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Statistiques de la ruche :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }
}
