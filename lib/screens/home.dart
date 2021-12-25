import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/screens/all_chantiers.dart';
import 'package:chantech/screens/all_equipements.dart';
import 'package:chantech/screens/all_ouvriers.dart';
import 'package:flutter/material.dart';

int? index;
List<ChantierCard> listChantiers = [
  ChantierCard(nom: 'La tour Eiffel', respo: 'Aboud', prop: 'Rachid Nekaz'),
];
List<EquipementCard> listEquipements = [
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
  EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
];
List<OuvrierCard> listOuvriers = [
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: myYellow,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              icon: Icon(
                Icons.house_rounded,
                color: index == 0 ? myBlue : Colors.white,
                size: index == 0 ? 35 : 30,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              icon: Icon(
                Icons.person,
                color: index == 1 ? myBlue : Colors.white,
                size: index == 1 ? 35 : 30,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
              icon: Icon(
                Icons.construction,
                color: index == 2 ? myBlue : Colors.white,
                size: index == 2 ? 35 : 30,
              ),
            ),
          ],
        ),
      ),
      body: index == 0
          ? AllChantiers(
              listChantiers: listChantiers,
            )
          : index == 1
              ? AllOuvriers(
                  listOuvriers: listOuvriers,
                )
              : AllEquipements(
                  listEquipements: listEquipements,
                ),
    );
  }
}