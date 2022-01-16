class Equipement {
  final int idEquipement;
  final int prix;
  final String libele;
  final int numEquipement;
  final int nb_echantillon;
  Equipement({
    required this.idEquipement,
    required this.libele,
    required this.numEquipement,
    required this.nb_echantillon,
    required this.prix,
  });
  factory Equipement.fromJson(Map<String, dynamic> json) {
    return Equipement(
        idEquipement: json['idEquipement'],
        libele: json['libele'],
        nb_echantillon: json['nb_echantillon'],
        numEquipement: json['numEquipement'],
        prix: json['prix']);
  }
}
