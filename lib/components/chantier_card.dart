import 'package:chantech/consts.dart';
import 'package:chantech/models/chantier.dart';
import 'package:chantech/screens/chantier_detaille.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';

class ChantierCard extends StatelessWidget {
  final int id;
  final Function update;
  final String nom;
  final String respo;
  final String prop;
  ChantierCard(
      {Key? key,
      required this.update,
      required this.nom,
      required this.respo,
      required this.prop,
      required this.id})
      : super(key: key);
  factory ChantierCard.fromChantier(Chantier e, Function update) {
    return ChantierCard(
        update: update,
        id: e.idChantier,
        nom: e.nomChantier,
        respo: "${e.nomResponsable} ${e.preNomResponsable}",
        prop: '${e.nomProprietaire} ${e.preNomProprietaire}');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!IsProp!)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChantierDetaille(
                        update: update,
                        id: id,
                      )));
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: myYellow,
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
                  'Responsable : $respo',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Proprietaire : $prop',
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
            Icons.house,
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
