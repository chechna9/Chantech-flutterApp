import 'dart:convert';

import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

bool? firstReg;
String nom = "";
String prenom = "";
String email = "";
String phoneNumber = "";
String password = "";

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void nextStep() {
    setState(() {
      firstReg = !firstReg!;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    firstReg = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        color: myBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/outlinedLogo.png',
              width: 180,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(height: 30),
            Expanded(
              // height: 400,
              child: SingleChildScrollView(
                child: firstReg == true
                    ? FirstRegisterCard(nextStep: nextStep)
                    : SecondRegisterCard(nextStep: nextStep),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirstRegisterCard extends StatefulWidget {
  final nextStep;
  FirstRegisterCard({
    Key? key,
    this.nextStep,
  }) : super(key: key);

  @override
  State<FirstRegisterCard> createState() => _FirstRegisterCardState();
}

class _FirstRegisterCardState extends State<FirstRegisterCard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: myYellow,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Nom
            TextFormField(
              decoration: myTFFDecoration('Nom'),
              onChanged: (value) => nom = value,
              validator: (val) => val!.isEmpty ? 'Remplir ce champ' : null,
            ),
            const SizedBox(height: 20),
            //Prénom
            TextFormField(
              decoration: myTFFDecoration('Prénom'),
              onChanged: (value) => prenom = value,
              validator: (val) => val!.isEmpty ? 'Remplir ce champ' : null,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Avez-vous déja un compte ?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: myBottomStyle(myBlue),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) widget.nextStep();
                    },
                    child: const Text(
                      'Suivant',
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
        ),
      ),
    );
  }
}

class SecondRegisterCard extends StatefulWidget {
  final nextStep;
  const SecondRegisterCard({
    Key? key,
    this.nextStep,
  }) : super(key: key);

  @override
  State<SecondRegisterCard> createState() => _SecondRegisterCardState();
}

class _SecondRegisterCardState extends State<SecondRegisterCard> {
  final _formKey = GlobalKey<FormState>();
  bool _emailExist = false;
  bool _phoneExist = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: myYellow,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Email
            TextFormField(
              decoration: myTFFDecoration('E-mail'),
              onChanged: (value) => email = value,
              validator: (val) => _emailExist
                  ? 'email existe deja'
                  : val!.isEmpty
                      ? 'Remplir ce champ'
                      : null,
            ),
            const SizedBox(height: 20),
            //Numero
            TextFormField(
              decoration: myTFFDecoration('Numéro de Telephone'),
              keyboardType: TextInputType.number,
              onChanged: (value) => phoneNumber = value,
              validator: (val) => _phoneExist
                  ? 'numero existe deja'
                  : val!.isEmpty
                      ? 'Remplir ce champ'
                      : null,
            ),
            const SizedBox(height: 20),
            //Password
            TextFormField(
              obscureText: true,
              decoration: myTFFDecoration('Mot de passe'),
              onChanged: (value) => password = value,
              validator: (val) =>
                  val!.length < 4 ? '4 caractères au minimum' : null,
            ),
            const SizedBox(height: 40),

            TextButton.icon(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                widget.nextStep();
              },
              label: const Text(
                'Retour arriére',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: myBottomStyle(myBlue),
                    onPressed: () async {
                      _emailExist = false;
                      _phoneExist = false;

                      if (_formKey.currentState!.validate()) {
                        final repsonseEmail = await http.get(
                            Uri.parse(localhost + 'personne/email/$email'));

                        final userDataE = jsonDecode(repsonseEmail.body);
                        print(userDataE['status']);

                        userDataE['status'] == 200
                            ? _emailExist = true
                            : _emailExist = false;

                        final repsonsePhone = await http.get(Uri.parse(
                            localhost + 'personne/numero/$phoneNumber'));

                        final userDataP = jsonDecode(repsonsePhone.body);
                        print(userDataP['status']);

                        userDataP['status'] == 200
                            ? _phoneExist = true
                            : _phoneExist = false;
                        if (_formKey.currentState!.validate()) {
                          final rgisterUrl = localhost +
                              'personne/nom/$nom/prenom/$prenom/numero/$phoneNumber/email/$email/mdp/$password';
                          await http.post(Uri.parse(rgisterUrl));
                          // Navigator.pushReplacementNamed(context, '/home');
                        }
                      }
                    },
                    child: const Text(
                      'S\'inscrire',
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
        ),
      ),
    );
  }
}
