import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOuvrier extends StatelessWidget {
  final Function update;
  AddOuvrier({Key? key, required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String nom = "";
    String prenom = "";
    String spec = "";
    int numTele = 0;
    String email = "";
    return Scaffold(
      backgroundColor: const Color(0x44ffffff),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
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
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //prenom
                    TextFormField(
                      decoration: myTFFDecoration('Prénom'),
                      onChanged: (value) => prenom = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Specialité
                    TextFormField(
                      decoration: myTFFDecoration('Specialité'),
                      onChanged: (value) => spec = value,
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //Numero de telephone
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: myTFFDecoration('Numero de télephone'),
                      onChanged: (value) => numTele = int.parse(value),
                      validator: (val) =>
                          val!.isEmpty ? 'Remplir ce champ' : null,
                    ),
                    const SizedBox(height: 20),
                    //email
                    TextFormField(
                      decoration: myTFFDecoration('Email'),
                      onChanged: (value) => email = value,
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
                                final addOuvrierUrl = localhost +
                                    'ouvrier/nom/$nom/prenom/$prenom/numero/$numTele/email/$email/specialite/$spec';
                                await http.post(Uri.parse(addOuvrierUrl));
                                await update();
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
