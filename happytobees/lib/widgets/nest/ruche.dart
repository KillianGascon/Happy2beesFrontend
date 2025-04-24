class Ruche {
  final String nomRuche;
  final int nombreCadresGlobal;

  Ruche({required this.nomRuche, required this.nombreCadresGlobal});

  factory Ruche.fromJson(Map<String, dynamic> json) {
    return Ruche(
      nomRuche: json['nom_ruche'],
      nombreCadresGlobal: json['nombre_cadres_corp'] + json['nombre_cadres_hausse'],
    );
  }
}
