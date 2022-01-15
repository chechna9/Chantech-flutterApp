import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';

class OuvrierDChantierCard extends StatefulWidget {
  final int idChantier;
  final int idOuvrier;
  final String nom;
  final String prenom;
  final String spec;
  bool isChef;
  OuvrierDChantierCard(
      {Key? key,
      required this.idChantier,
      required this.idOuvrier,
      required this.nom,
      required this.prenom,
      required this.spec,
      required this.isChef})
      : super(key: key);
  factory OuvrierDChantierCard.fromOuvrier(
      Ouvrier e, bool isChef, int idChantier) {
    return OuvrierDChantierCard(
      nom: e.nom,
      prenom: e.prenom,
      spec: e.spec,
      isChef: isChef,
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
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: myYellow,
        borderRadius: BorderRadius.circular(20),
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
                  setState(() {
                    widget.isChef = !widget.isChef;
                  });
                },
                child: widget.isChef
                    ? const Text(
                        'Respo',
                        style: TextStyle(color: myBlue),
                      )
                    : const Text(
                        'Rendre respo',
                        style: TextStyle(color: Colors.white),
                      ),
                style: widget.isChef
                    ? myBottomStyle(Colors.white)
                    : myBottomStyle(myBlue),
              )
            ],
          ),
        ],
      ),
    );
  }
}
