import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OuvrierDTache extends StatelessWidget {
  final int idTache;
  final int idOuvrier;
  final String nom;
  final String prenom;
  final String spec;
  OuvrierDTache(
      {Key? key,
      required this.idTache,
      required this.idOuvrier,
      required this.nom,
      required this.prenom,
      required this.spec})
      : super(key: key);
  factory OuvrierDTache.fromOuvrier(Ouvrier e, int idTache) {
    return OuvrierDTache(
      nom: e.nom,
      prenom: e.prenom,
      spec: e.spec,
      idOuvrier: e.id,
      idTache: idTache,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final addOuvrierUrl =
            localhost + 'ouvrier/idOuvrier/$idOuvrier/idTache/$idTache';
        await http.post(Uri.parse(addOuvrierUrl));
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20),
        elevation: 0,
        backgroundColor: myYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nom : $nom',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Prénom : $prenom',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Spécialité : $spec',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
