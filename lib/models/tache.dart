class Tache {
  final int idTache;
  final int idChantier;
  final String nom;
  final int duree;
  final String description;
  final int termine;
  Tache({
    required this.idTache,
    required this.idChantier,
    required this.description,
    required this.duree,
    required this.nom,
    required this.termine,
  });
  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
        idTache: json['idTache'],
        idChantier: json['idChantier'],
        description: json['description'],
        duree: json['duree'],
        nom: json['nom'],
        termine: json['termine']);
  }
}
