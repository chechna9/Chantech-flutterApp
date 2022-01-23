import 'package:chantech/consts.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
            const Expanded(
              child: SingleChildScrollView(
                child: LoginCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool _emailExist = true;
  bool _passwordCorrect = true;
  String password = "";
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
                validator: (val) => !_emailExist
                    ? 'email n\'existe pas'
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
                validator: (val) => !_passwordCorrect
                    ? 'mot de passe incorrecte'
                    : val!.length < 4
                        ? '4 caractères au minimum'
                        : null,
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text(
                  'Creer un nouveau compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: myBottomStyle(myBlue),
                      onPressed: () async {
                        _emailExist = true;
                        _passwordCorrect = true;

                        if (_formKey.currentState!.validate()) {
                          //cannot sent header after resent
                          final repsonseEmail = await http.get(
                              Uri.parse(localhost + 'personne/email/$email'));
                          final userDataE = jsonDecode(repsonseEmail.body);

                          userDataE['status'] == 200
                              ? _emailExist = true
                              : _emailExist = false;

                          if (_formKey.currentState!.validate()) {
                            final loginUrl = localhost +
                                'personne/email/$email/mdp/$password';
                            final loginResponse =
                                await http.get(Uri.parse(loginUrl));
                            final userDataP = jsonDecode(loginResponse.body);

                            userDataP['status'] == 100
                                ? _passwordCorrect = false
                                : _passwordCorrect = true;
                            if (_formKey.currentState!.validate()) {
                              IsAdmin = userDataP['role'] == 'admin';
                              IsOuvrier = userDataP['role'] == 'ouvrier';
                              IsResp = userDataP['role'] == 'responsable';
                              IsProp = userDataP['role'] == '<UKN>';
                              idGlob = userDataE['data'][0]['idPersonne'];
                              print('admin $IsAdmin');
                              print('resp $IsResp');
                              print('ouvr $IsOuvrier');
                              print('prop $IsProp');
                              if (IsAdmin!) {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, '/homeLite');
                              }
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Se Connecter',
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
    );
  }
}
