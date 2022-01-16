class Personne {
  final String nom;
  final String prenom;
  final String email;
  final int numero;
  final String mdp;
  final int admin;
  Personne({
    required this.admin,
    required this.email,
    required this.mdp,
    required this.nom,
    required this.numero,
    required this.prenom,
  });
  factory Personne.fomJson(Map<String, dynamic> json) {
    return Personne(
      admin: json['admin'],
      email: json['email'],
      mdp: json['mdp'],
      nom: json['nom'],
      numero: json['numero'],
      prenom: json['prenom'],
    );
  }
}
