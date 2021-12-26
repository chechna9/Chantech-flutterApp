import 'package:chantech/screens/chantier_detaille.dart';
import 'package:chantech/screens/home.dart';
import 'package:chantech/screens/login.dart';
import 'package:chantech/screens/register.dart';
import 'package:chantech/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/chantierDetaille',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => Register(),
        '/home': (context) => const Home(),
        '/chantierDetaille': (context) => const ChantierDetaille(),
      },
    ),
  );
}
