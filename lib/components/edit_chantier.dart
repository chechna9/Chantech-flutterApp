import 'dart:convert';

import 'package:chantech/consts.dart';
import 'package:chantech/models/chantier.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditChantier extends StatelessWidget {
  final int idChantier;
  final Function update;
  final Chantier chantier;
  EditChantier(
      {Key? key,
      required this.idChantier,
      required this.update,
      required this.chantier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _propExist = true;
    bool _respExist = true;
    bool _dejaRespo = false;

    final _formkey = GlobalKey<FormState>();
    String nom = chantier.nomChantier;
    String prop = chantier.emailProprietaire;
    String respo = chantier.emailResponsable;
    String adr = chantier.address;

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
                      initialValue: nom,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //adresse du chantier
                    TextFormField(
                      decoration: myTFFDecoration('Adresse du chantier'),
                      onChanged: (value) => adr = value,
                      initialValue: adr,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //proprietaire
                    TextFormField(
                      decoration: myTFFDecoration('Email du Proprietaire'),
                      onChanged: (value) => prop = value,
                      initialValue: prop,
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
                      initialValue: respo,
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
                                  //getting responsable

                                  final editChantierUrl = localhost +
                                      'chantier/idchantier/$idChantier/nomChantier/$nom/emailproprietaire/$prop/emailresponsable/$respo/address/$adr';
                                  try {
                                    final result = await http
                                        .put(Uri.parse(editChantierUrl));
                                    if (jsonDecode(result.body)['status'] ==
                                        100) _dejaRespo = true;
                                    print(result.body);
                                  } catch (e) {
                                    print('error');
                                  }
                                  if (_formkey.currentState!.validate()) {
                                    await update();
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Modifier',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22),
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
