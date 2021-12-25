import 'dart:ffi';

import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AddEquipement extends StatelessWidget {
  final Function updateList;

  AddEquipement({Key? key, required this.updateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String libelle = "";
    String num = "";
    double prix = 0;
    int rest = 0;
    return Scaffold(
      backgroundColor: const Color(0x44ffffff),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
        child: Container(
          decoration: const BoxDecoration(
              color: myYellow,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Libellé
                    TextFormField(
                      decoration: myTFFDecoration('Libellé'),
                      onChanged: (value) => libelle = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Numéro
                    TextFormField(
                      decoration: myTFFDecoration('Numéro'),
                      onChanged: (value) => num = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Prix de vent
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      decoration: myTFFDecoration('Prix de vent'),
                      onChanged: (value) => prix = double.parse(value),
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //quantité
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      decoration: myTFFDecoration('Quantitée'),
                      onChanged: (value) => rest = int.parse(value),
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),

                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: myBottomStyle(Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Annuler',
                              style: TextStyle(
                                  color: myBlue,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            style: myBottomStyle(myBlue),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                updateList(EquipementCard(
                                    libelle: libelle, num: num, rest: rest));
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Ajouter',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
