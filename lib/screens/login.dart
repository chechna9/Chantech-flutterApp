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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/outlinedLogo.png',
              width: 180,
              fit: BoxFit.scaleDown,
            ),
            const LoginCard(),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: myYellow,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Email
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextFormField(
                decoration: myTFFDecoration('E-mail'),
              ),
            ),
            const SizedBox(height: 20),
            //Password
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextFormField(
                decoration: myTFFDecoration('Mot de passe'),
              ),
            ),
            const SizedBox(height: 40),
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
              onPressed: () {},
              child: const Text(
                'Creer un nouveau compte',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 50),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      backgroundColor: myBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
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
      ),
    );
  }
}
