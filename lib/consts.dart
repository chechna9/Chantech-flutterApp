import 'package:flutter/material.dart';

const myBlue = Color(0xff14213D);
const myYellow = Color(0xffFCA311);
InputDecoration myTFFDecoration(String hint) => InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
ButtonStyle myBottomStyle(Color color) => TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

//Api endpoints
//ouvriers
const urlOuvrierDispo = 'http://10.0.2.2:8080/ouvrier/libre';
const urlOuvrierOcup = 'http://10.0.2.2:8080/ouvrier/occupe';
//chantiers
const urlChnaitersEnCours = 'http://10.0.2.2:8080/chantier/courant';
const urlChnaitersTerminer = 'http://10.0.2.2:8080/chantier/fermer';
