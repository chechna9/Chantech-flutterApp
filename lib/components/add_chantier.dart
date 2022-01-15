import 'dart:convert';

import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddChantier extends StatelessWidget {
  AddChantier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _propExist = true;
    bool _respExist = true;
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
                      validator: (val) => !_respExist
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
                                  final fetchResponsableResponse =
                                      await http.get(Uri.parse(localhost +
                                          'ouvrier/info/email/$respo'));
                                  final responsableData = jsonDecode(
                                      fetchResponsableResponse.body)['data'][0];
                                  Ouvrier responsable =
                                      Ouvrier.fromJson(responsableData);
                                  // getting proprietaire
                                  final proprietaireData =
                                      jsonDecode(propResponse.body)['data'][0];

                                  final addChantierUrl = localhost +
                                      'chantier/nomchantier/$nom/emailproprietaire/$prop/emailresponsable/$respo/address/$adr';
                                  await http.post(Uri.parse(addChantierUrl));

                                  Navigator.pop(context);
                                  // yyyyyy@estin.dz
                                  // tizi@gmail.com
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
