import 'package:chantech/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
            const LoginCard(),
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
                validator: (val) => val!.isEmpty ? 'Remplir ce champ' : null,
              ),
              const SizedBox(height: 20),
              //Password
              TextFormField(
                obscureText: true,
                decoration: myTFFDecoration('Mot de passe'),
                onChanged: (value) => password = value,
                validator: (val) =>
                    val!.length < 6 ? '6 caractères au minimum' : null,
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
                      onPressed: () {
                        // Navigator.pushReplacementNamed(context, '/home');
                        print(email);
                        print(password);
                        _formKey.currentState!.validate();
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
