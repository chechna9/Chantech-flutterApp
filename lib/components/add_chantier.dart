import 'dart:convert';

import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddChantier extends StatefulWidget {
  List<ChantierCard> updateListEncours;
  List<ChantierCard> updateListTerminer;
  final Function update;
  AddChantier(
      {Key? key,
      required this.updateListEncours,
      required this.updateListTerminer,
      required this.update})
      : super(key: key);

  @override
  State<AddChantier> createState() => _AddChantierState();
}

class _AddChantierState extends State<AddChantier> {
  @override
  Widget build(BuildContext context) {
    bool _propExist = true;
    bool _respExist = true;
    bool _dejaRespo = false;
    final _formkey = GlobalKey<FormState>();
    String nom = "";
    String prop = "";
    String respo = "";
    String adr = "";

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
                    //nom du chantier
                    TextFormField(
                      decoration: myTFFDecoration('Nom du chantier'),
                      onChanged: (value) => nom = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //adresse du chantier
                    TextFormField(
                      decoration: myTFFDecoration('Adresse du chantier'),
                      onChanged: (value) => adr = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //proprietaire
                    TextFormField(
                      decoration: myTFFDecoration('Email du Proprietaire'),
                      onChanged: (value) => prop = value,
                      validator: (val) => !_propExist
                          ? 'Proprietaire n\'existe pas'
                          : val!.isEmpty
                              ? 'Remplir ce champ'
                              : null,
                    ),
                    const SizedBox(height: 20),
                    //responsable
                    TextFormField(
                      decoration: myTFFDecoration('Email du Responsable'),
                      onChanged: (value) => respo = value,
                      validator: (val) => _dejaRespo
                          ? 'Responsable existe deja'
                          : !_respExist
                              ? 'Responsable n\'existe pas'
                              : val!.isEmpty
                                  ? 'Remplir ce champ'
                                  : null,
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
                            onPressed: () async {
                              _propExist = true;
                              _respExist = true;
                              _dejaRespo = false;
                              if (_formkey.currentState!.validate()) {
                                // 120 ouvrier // personne 100 // error
                                final respResponse = await http
                                    .get(Uri.parse(urlRespVal + respo));

                                final propResponse = await http
                                    .get(Uri.parse(urlPropVal + prop));
                                if (jsonDecode(propResponse.body)['status'] ==
                                    100) {
                                  _propExist = false;
                                } else {
                                  _propExist = true;
                                }
                                if (jsonDecode(respResponse.body)['status'] ==
                                    120) {
                                  _respExist = false;
                                } else {
                                  _respExist = true;
                                }

                                if (_formkey.currentState!.validate()) {
                                  final addChantierUrl = localhost +
                                      'chantier/nomchantier/$nom/emailproprietaire/$prop/emailresponsable/$respo/address/$adr';

                                  try {
                                    final result = await http
                                        .post(Uri.parse(addChantierUrl));
                                    print(result.body);
                                    if (jsonDecode(result.body)['status'] ==
                                        100) _dejaRespo = true;
                                    print(result.body);
                                  } catch (e) {
                                    print('error');
                                  }
                                  if (_formkey.currentState!.validate()) {
                                    // setState(
                                    //   () {
                                    //     widget.updateListEncours.add(
                                    //       ChantierCard(
                                    //         nom: nom,
                                    //         respo: respo,
                                    //         prop: prop,
                                    //         id: 0,
                                    //         update: widget.update,
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                    widget.update();
                                    Navigator.pop(context);
                                  }
                                }
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
