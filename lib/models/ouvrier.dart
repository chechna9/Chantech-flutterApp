class Ouvrier {
  final String nom;
  final String prenom;
  final String email;
  final int numero;
  final int id;

  final String spec;
  Ouvrier({
    required this.id,
    required this.email,
    required this.nom,
    required this.numero,
    required this.prenom,
    required this.spec,
  });
  factory Ouvrier.fromJson(Map<String, dynamic> json) {
    return Ouvrier(
      id: json['idPersonne'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      numero: json['numero'],
      spec: json['nomSpecialite'],
    );
  }
}
