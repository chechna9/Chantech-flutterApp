import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/screens/affect_respo.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';

class OuvrierDChantierCard extends StatefulWidget {
  final int idChantier;
  final int idOuvrier;
  final String nom;
  final String prenom;
  final String spec;
  final Function update;
  OuvrierDChantierCard({
    Key? key,
    required this.update,
    required this.idChantier,
    required this.idOuvrier,
    required this.nom,
    required this.prenom,
    required this.spec,
  }) : super(key: key);
  factory OuvrierDChantierCard.fromOuvrier(
      Ouvrier e, int idChantier, Function update) {
    return OuvrierDChantierCard(
      update: update,
      nom: e.nom,
      prenom: e.prenom,
      spec: e.spec,
      idChantier: idChantier,
      idOuvrier: e.id,
    );
  }
  @override
  State<OuvrierDChantierCard> createState() => _OuvrierDChantierCardState();
}

class _OuvrierDChantierCardState extends State<OuvrierDChantierCard> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (IsAdmin! || IsResp!)
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => OuvrierDetaille(
                id: widget.idOuvrier,
                update: widget.update,
              ),
            ),
          );
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
                  'Nom : ${widget.nom}',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Prénom : ${widget.prenom}',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Spécialité : ${widget.spec}',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
              TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         AffectRespo(idChantier: widget.idChantier),
                  //   ),
                  // );
                },
                child: const Text(
                  'Responsable',
                  style: TextStyle(color: Colors.white),
                ),
                style: myBottomStyle(myBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
