import 'package:chantech/screens/add_ouvrier_d_chantier.dart';
import 'package:chantech/screens/ajout_ouvrier_d_tache.dart';
import 'package:chantech/screens/all_taches.dart';
import 'package:chantech/screens/chantier_detaille.dart';
import 'package:chantech/screens/equipement_detaille.dart';
import 'package:chantech/screens/home.dart';
import 'package:chantech/screens/login.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:chantech/screens/register.dart';
import 'package:chantech/screens/splash_screen.dart';
import 'package:chantech/screens/tache_detaille.dart';
import 'package:flutter/material.dart';
import 'screens/ouvrier_dans_tache.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/addOuvrierDansChantier',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => Register(),
        '/home': (context) => const Home(),
        '/chantierDetaille': (context) => const ChantierDetaille(),
        '/ouvrierDetaille': (context) => const OuvrierDetaille(),
        '/equipementDetaille': (context) => const EquipementDetaille(),
        '/ouvrierDansTache': (context) => const OuvrierDansTache(),
        '/addOuvrierDansTache': (context) => AddOuvrierDTache(),
        '/allTaches': (context) => AllTaches(),
        '/tacheDetaille': (context) => const TacheDetaille(),
        '/addOuvrierDansChantier': (context) => AddOuvrierDChantier(),
      },
    ),
  );
}
