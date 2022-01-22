import 'package:chantech/consts.dart';
import 'package:chantech/models/tache.dart';
import 'package:chantech/screens/tache_detaille.dart';
import 'package:flutter/material.dart';

class TacheCard extends StatelessWidget {
  final int id;
  final String nom;
  final int dure;
  final Function update;
  const TacheCard({
    Key? key,
    required this.update,
    required this.nom,
    required this.dure,
    required this.id,
  }) : super(key: key);
  factory TacheCard.fromTache(Tache e, Function update) {
    return TacheCard(
      nom: e.nom,
      dure: e.duree,
      id: e.idTache,
      update: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TacheDetaille(
              id: id,
              update: update,
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: myYellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
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
                  'Durée : $dure',
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
            Icons.toc_sharp,
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
