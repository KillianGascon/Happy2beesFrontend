import 'package:happytobees/api_service.dart';
import 'package:happytobees/widgets/nest/ruche.dart';

class RucheService {
  final ApiService apiService = ApiService();

  Future<List<Ruche>> fetchRuches(int utilisateurId) async {
    try {
      final data = await apiService.get('ruches/getByUtilisateur/$utilisateurId');
      if (data == null) {
        throw Exception("Aucune donnée reçue.");
      }
      return (data as List).map((ruche) => Ruche.fromJson(ruche)).toList();
    } catch (e) {
      print('Erreur lors de la récupération des ruches : $e');
      return []; // Retourne une liste vide en cas d'erreur
    }
  }
}
