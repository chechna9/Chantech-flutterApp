class Ouvrier {
  final String nom;
  final String prenom;
  final String email;
  final int numero;
  final String spec;
  Ouvrier({
    required this.email,
    required this.nom,
    required this.numero,
    required this.prenom,
    required this.spec,
  });
  factory Ouvrier.fromJson(Map<String, dynamic> json) {
    return Ouvrier(
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      numero: json['numero'],
      spec: json['nomspecialite'],
    );
  }
}
