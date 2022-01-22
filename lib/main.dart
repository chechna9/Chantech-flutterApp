import 'package:chantech/screens/add_equipement_d_chantier.dart';
import 'package:chantech/screens/equipement_dans_chantier.dart';
import 'package:chantech/screens/equipement_detaille.dart';
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
      initialRoute: '/home',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => Register(),
        '/home': (context) => const Home(),
        // '/chantierDetaille': (context) => const ChantierDetaille(),
        // '/ouvrierDetaille': (context) => const OuvrierDetaille(),
        // '/equipementDetaille': (context) => const EquipementDetaille(),
        // '/ouvrierDansChantier': (context) => const OuvrierDansChantier(),
        // '/addOuvrierDansTache': (context) => AddOuvrierDTache(),
        // '/allTaches': (context) => AllTaches(),
        // '/tacheDetaille': (context) => const TacheDetaille(),
        // '/addOuvrierDansChantier': (context) => AddOuvrierDChantier(),
        '/equipementDansChantier': (context) => const EquipementDansChantier(),
        '/addEquipementDansChantier': (context) => AddEquipementDansChantier(),
      },
    ),
  );
}
