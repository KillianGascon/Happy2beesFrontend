class Ruche {
  final int id;
  final int? idApiculteur;
  final String? photoRuche;
  final int? numeroRuche;
  final String? nomRuche;
  final int? nombreCadresCorp;
  final int? nombreHausses;
  final int? nombreCadresHausse;
  final int? nombreCadreCouvain;
  final int? nombreCadreNourriture;
  final int? nombreCadreLibre;

  Ruche({
    required this.id,
    this.idApiculteur,
    this.photoRuche,
    this.numeroRuche,
    this.nomRuche,
    this.nombreCadresCorp,
    this.nombreHausses,
    this.nombreCadresHausse,
    this.nombreCadreCouvain,
    this.nombreCadreNourriture,
    this.nombreCadreLibre,
  });

  // Méthode pour convertir un JSON en instance de Ruche
  factory Ruche.fromJson(Map<String, dynamic> json) {
    return Ruche(
      id: json['id'] as int,
      idApiculteur: json['id_apiculteur'] as int?,
      photoRuche: json['photo_ruche'] as String?,
      numeroRuche: json['numero_ruche'] as int?,
      nomRuche: json['nom_ruche'] as String?,
      nombreCadresCorp: json['nombre_cadres_corp'] as int?,
      nombreHausses: json['nombre_hausses'] as int?,
      nombreCadresHausse: json['nombre_cadres_hausse'] as int?,
      nombreCadreCouvain: json['nombre_cadre_couvain'] as int?,
      nombreCadreNourriture: json['nombre_cadre_nourriture'] as int?,
      nombreCadreLibre: json['nombre_cadre_libre'] as int?,
    );
  }

  // Méthode pour convertir une instance de Ruche en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idApiculteur': idApiculteur,
      'photoRuche': photoRuche,
      'numeroRuche': numeroRuche,
      'nomRuche': nomRuche,
      'nombreCadresCorp': nombreCadresCorp,
      'nombreHausses': nombreHausses,
      'nombreCadresHausse': nombreCadresHausse,
      'nombreCadreCouvain': nombreCadreCouvain,
      'nombreCadreNourriture': nombreCadreNourriture,
      'nombreCadreLibre': nombreCadreLibre,
    };
  }
}
