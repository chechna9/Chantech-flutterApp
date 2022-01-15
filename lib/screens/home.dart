import 'dart:convert';

import 'package:chantech/models/chantier.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/screens/all_chantiers.dart';
import 'package:chantech/screens/all_equipements.dart';
import 'package:chantech/screens/all_ouvriers.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int? index;
List<ChantierCard> listChantiersEnCours = [];
List<ChantierCard> listChantiersTerminer = [];

List<EquipementCard> listEquipementsDispo = [];
List<EquipementCard> listEquipementsOcup = [];

List<OuvrierCard> listOuvriersDispo = [];
List<OuvrierCard> listOuvriersOcup = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> fetchOuvriers() async {
    final responseDispo = await http.get(Uri.parse(urlOuvrierDispo));
    final responseOcup = await http.get(Uri.parse(urlOuvrierOcup));
    //getting ouvrier disponible
    if (responseDispo.statusCode == 200) {
      final List _listData = jsonDecode(responseDispo.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      setState(() {
        for (Ouvrier e in _listData) {
          listOuvriersDispo.add(OuvrierCard.fromOuvrier(
            e,
            () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => OuvrierDetaille(
                    id: e.id,
                  ),
                ),
              );
            },
          ));
        }
      });
    }
    //getting ouvrier occupe
    if (responseOcup.statusCode == 200) {
      final List _listData = jsonDecode(responseOcup.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();

      setState(() {
        for (Ouvrier e in _listData) {
          listOuvriersOcup.add(OuvrierCard.fromOuvrier(
            e,
            () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => OuvrierDetaille(
                    id: e.id,
                  ),
                ),
              );
            },
          ));
        }
      });
    }
  }

  Future<void> fetchEquipements() async {
    // final responseDispo = await http.get(Uri.parse(urlOuvrierDispo));
    // final responseOcup = await http.get(Uri.parse(urlOuvrierOcup));
    // //getting ouvrier disponible
    // if (responseDispo.statusCode == 200) {
    //   final List _listData = jsonDecode(responseDispo.body)['data']
    //       .map((data) => Ouvrier.fromJson(data))
    //       .toList();
    //   setState(() {
    //     for (Ouvrier e in _listData) {
    //       listOuvriersDispo.add(OuvrierCard.fromOuvrier(e));
    //     }
    //   });
    // }
    // //getting ouvrier occupe
    // if (responseOcup.statusCode == 200) {
    //   final List _listData = jsonDecode(responseOcup.body)['data']
    //       .map((data) => Ouvrier.fromJson(data))
    //       .toList();

    //   setState(() {
    //     for (Ouvrier e in _listData) {
    //       listOuvriersOcup.add(OuvrierCard.fromOuvrier(e));
    //     }
    //   });
    // }
  }

  Future<void> fetchChantiers() async {
    final responseEnCours = await http.get(Uri.parse(urlChnaitersEnCours));
    print(responseEnCours.body);
    final responseTerminer = await http.get(Uri.parse(urlChnaitersTerminer));
    //getting chantier En cours
    if (responseEnCours.statusCode == 200) {
      final List _listData = jsonDecode(responseEnCours.body)['data']
          .map((data) => Chantier.fromJson(data))
          .toList();
      setState(() {
        for (Chantier e in _listData) {
          listChantiersEnCours.add(ChantierCard.fromChantier(e));
        }
      });
    }
    //getting ouvrier occupe
    if (responseTerminer.statusCode == 200) {
      final List _listData = jsonDecode(responseTerminer.body)['data']
          .map((data) => Chantier.fromJson(data))
          .toList();

      setState(() {
        for (Chantier e in _listData) {
          listChantiersTerminer.add(ChantierCard.fromChantier(e));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOuvriers();
    fetchChantiers();
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
              listChantiersEnCours: listChantiersEnCours,
              listChantiersTerminer: listChantiersTerminer,
            )
          : index == 1
              ? AllOuvriers(
                  listOuvriersDispo: listOuvriersDispo,
                  listOuvriersOcup: listOuvriersOcup,
                )
              : AllEquipements(
                  listEquipementsDispo: listEquipementsDispo,
                  listEquipementsOcup: listEquipementsOcup,
                ),
    );
  }
}
