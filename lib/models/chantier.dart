class Chantier {
// "idProprietaire": 1,
//             "nomProprietaire": "Almamma",
//             "prenomProprietaire": "Amir",
//             "numeroProprietaire": 123123,
//             "emailProprietaire": "aaa@gmail.com",
//             "mdpProprietaire": "0000",
//             "idResponsable": 36,
//             "nomResponsable": "kadi",
//             "prenomResponsable": "Mazene",
//             "numeroResponsable": 1464687,
//             "emailResponsable": "ccc@gmail.com",
//             "mdpResponsable": "0000",
//             "idChantier": 1,
//             "nomChantier": "Chantier les frere",
//             "proprietaire": 1,
//             "responsable": 36,
//             "address": "rue 54 - zemourie"
  final String nomChantier;
  final String nomProprietaire;
  final String preNomProprietaire;
  final int idProprietaire;
  final String nomResponsable;
  final String preNomResponsable;
  final String emailResponsable;
  final String emailProprietaire;
  final int idResponsable;
  final int fermer;
  final String address;
  final int idChantier;
  Chantier({
    required this.emailProprietaire,
    required this.emailResponsable,
    required this.idChantier,
    required this.idProprietaire,
    required this.idResponsable,
    required this.nomChantier,
    required this.preNomProprietaire,
    required this.nomProprietaire,
    required this.nomResponsable,
    required this.preNomResponsable,
    required this.fermer,
    required this.address,
  });
  factory Chantier.fromJson(Map<String, dynamic> json) {
    return Chantier(
      emailProprietaire: json['emailProprietaire'],
      emailResponsable: json['emailResponsable'],
      idChantier: json['idChantier'],
      nomChantier: json['nomChantier'],
      idProprietaire: json['idProprietaire'],
      nomProprietaire: json['nomProprietaire'] ?? '/',
      preNomProprietaire: json['prenomProprietaire'] ?? '/',
      idResponsable: json['idResponsable'],
      preNomResponsable: json['prenomResponsable'] ?? '/',
      nomResponsable: json['nomResponsable'] ?? '/',
      fermer: json['fermer'],
      address: json['address'],
    );
  }
}
