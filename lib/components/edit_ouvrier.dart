import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class EditOuvrier extends StatelessWidget {
  // final Function updateList;

  EditOuvrier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String nom = "";
    String prop = "";
    String respo = "";
    double dure = 0;
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
                    //proprietaire
                    TextFormField(
                      decoration: myTFFDecoration('Proprietaire'),
                      onChanged: (value) => prop = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //responsable
                    TextFormField(
                      decoration: myTFFDecoration('Responsable'),
                      onChanged: (value) => respo = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //duree
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      decoration: myTFFDecoration('Duré'),
                      onChanged: (value) => dure = double.parse(value),
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
                                Navigator.pop(context);
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
