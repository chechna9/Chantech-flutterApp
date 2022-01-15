import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTache extends StatelessWidget {
  final int idChantier;

  AddTache({Key? key, required this.idChantier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String nom = "";
    int dure = 0;
    String descrpt = "";
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
                    //nom de la tache
                    TextFormField(
                      decoration: myTFFDecoration('Nom'),
                      onChanged: (value) => nom = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //durée de la tache
                    TextFormField(
                      decoration: myTFFDecoration('Durée'),
                      onChanged: (value) => dure = int.parse(value),
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //description de la tache

                    TextFormField(
                      decoration: myTFFDecoration('Description'),
                      onChanged: (value) => descrpt = value,
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
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                final addTacheUrl = localhost +
                                    'tache/chantier/$idChantier/nom/$nom/duree/$dure/description/$descrpt';
                                final response =
                                    await http.post(Uri.parse(addTacheUrl));
                                print(response.body);
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
