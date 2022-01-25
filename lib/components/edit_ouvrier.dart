import 'dart:convert';

import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditOuvrier extends StatelessWidget {
  final int idOuvrier;
  final Function update;
  final Ouvrier? ouvrier;
  EditOuvrier(
      {Key? key,
      required this.idOuvrier,
      required this.update,
      required this.ouvrier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    bool _userExists = true;
    bool _phoneExist = false;

    String nom = ouvrier != null ? ouvrier!.nom : '';
    String prenom = ouvrier != null ? ouvrier!.prenom : '';

    String spec = ouvrier != null ? ouvrier!.spec : '';
    int numTele = ouvrier != null ? ouvrier!.numero : 0;
    String email = ouvrier != null ? ouvrier!.email : '';
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
                      decoration: myTFFDecoration('Nom'),
                      onChanged: (value) => nom = value,
                      initialValue: nom,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //prenom
                    TextFormField(
                      decoration: myTFFDecoration('Prénom'),
                      onChanged: (value) => prenom = value,
                      initialValue: prenom,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Specialité
                    TextFormField(
                      decoration: myTFFDecoration('Specialité'),
                      onChanged: (value) => spec = value,
                      initialValue: spec,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Numero de telephone
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: myTFFDecoration('Numero de télephone'),
                      onChanged: (value) => numTele = int.parse(value),
                      initialValue: numTele.toString(),
                      validator: (val) => _phoneExist
                          ? 'numero existe deja'
                          : val!.isEmpty
                              ? 'Remplir ce champ'
                              : null,
                    ),
                    const SizedBox(height: 20),
                    //email
                    TextFormField(
                      decoration: myTFFDecoration('Email'),
                      onChanged: (value) => email = value,
                      initialValue: email,
                      validator: (val) => _userExists
                          ? 'Email existe déja'
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
                              _userExists = false;
                              _phoneExist = false;
                              if (_formkey.currentState!.validate()) {
                                final userResponse = await http
                                    .get(Uri.parse(urlRespVal + email));
                                print("email response ${userResponse.body}");

                                if (jsonDecode(userResponse.body)['status'] ==
                                    120) {
                                  _userExists = false;
                                } else {
                                  if (jsonDecode(userResponse.body)['data'][0]
                                          ['idOuvrier'] !=
                                      idOuvrier) {
                                    _userExists = true;
                                  }
                                }
                                final repsonsePhone = await http.get(Uri.parse(
                                    localhost + 'personne/numero/$numTele'));

                                final userDataP =
                                    jsonDecode(repsonsePhone.body);
                                print("phone response ${userDataP}");

                                if (userDataP['status'] == 200 &&
                                    userDataP['data'][0]['idPersonne'] !=
                                        idOuvrier) {
                                  _phoneExist = true;
                                } else {
                                  _phoneExist = false;
                                }
                                if (_formkey.currentState!.validate()) {
                                  final editOuvrierUrl = localhost +
                                      'ouvrier/id/$idOuvrier/nom/$nom/prenom/$prenom/numero/$numTele/email/$email/specialite/$spec';
                                  await http.put(Uri.parse(editOuvrierUrl));
                                  await update();

                                  Navigator.pop(context);
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
