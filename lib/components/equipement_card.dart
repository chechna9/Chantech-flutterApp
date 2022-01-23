import 'package:chantech/consts.dart';
import 'package:chantech/models/equipement.dart';
import 'package:chantech/screens/equipement_detaille.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';

class EquipementCard extends StatelessWidget {
  final Function action;
  final String libelle;
  final int num;
  final int rest;
  EquipementCard({
    Key? key,
    required this.action,
    required this.libelle,
    required this.num,
    required this.rest,
  }) : super(key: key);
  factory EquipementCard.fromEquipement(Equipement e, Function action) {
    return EquipementCard(
      action: action,
      libelle: e.libele,
      num: e.numEquipement,
      rest: e.nb_echantillon,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (IsAdmin! || IsResp!) action();
      },
      style: myBottomStyle(myYellow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Libellé : $libelle',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Numéro : $num',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Restants : $rest',
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
            Icons.construction,
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
