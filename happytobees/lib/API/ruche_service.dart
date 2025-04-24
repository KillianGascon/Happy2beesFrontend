import 'package:happytobees/api_service.dart';
import 'package:happytobees/widgets/nest/ruche.dart';

class RucheService {
  final ApiService apiService = ApiService();

  Future<List<Ruche>> fetchRuches() async {
    final data = await apiService.get('ruches');
    return (data as List).map((ruche) => Ruche.fromJson(ruche)).toList();
  }
}