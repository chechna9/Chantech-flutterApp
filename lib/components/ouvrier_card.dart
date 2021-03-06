import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';

class OuvrierCard extends StatelessWidget {
  final Function action;
  final int id;
  final String nom;
  final String prenom;
  final String spec;
  const OuvrierCard(
      {Key? key,
      required this.action,
      required this.id,
      required this.nom,
      required this.prenom,
      required this.spec})
      : super(key: key);
  factory OuvrierCard.fromOuvrier(Ouvrier e, Function action) {
    return OuvrierCard(
      nom: e.nom,
      prenom: e.prenom,
      spec: e.spec,
      id: e.id,
      action: action,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (IsAdmin! || IsResp!) action();
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
