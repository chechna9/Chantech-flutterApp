import 'dart:convert';

import 'package:chantech/components/add_tache.dart';
import 'package:chantech/components/tache_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/tache.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllTaches extends StatefulWidget {
  final int id;
  AllTaches({Key? key, required this.id}) : super(key: key);

  @override
  _AllTachesState createState() => _AllTachesState();
}

class _AllTachesState extends State<AllTaches> {
  List<TacheCard> _listTachesEncours = [];
  List<TacheCard> _listTachesTermine = [];
  void addTache() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AddTache(
          idChantier: widget.id,
        );
      },
    );
  }

  Future<void> fetchTaches() async {
    final responseEnCours = await http.get(
        Uri.parse(localhost + 'chantier/idChantier/${widget.id}/tacheCourant'));
    final responseTerminer = await http.get(Uri.parse(
        localhost + 'chantier/idChantier/${widget.id}/tacheTerminer'));
    //getting taches En cours
    if (responseEnCours.statusCode == 200) {
      final List _listData = jsonDecode(responseEnCours.body)['data']
          .map((data) => Tache.fromJson(data))
          .toList();
      setState(() {
        for (Tache e in _listData) {
          _listTachesEncours.add(TacheCard.fromTache(e));
        }
      });
    }
    //getting tache terminer
    if (responseTerminer.statusCode == 200) {
      final List _listData = jsonDecode(responseTerminer.body)['data']
          .map((data) => Tache.fromJson(data))
          .toList();

      setState(() {
        for (Tache e in _listData) {
          _listTachesTermine.add(TacheCard.fromTache(e));
        }
      });
    }
  }

  bool? enCours;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTaches();
    enCours = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 200,
        leading: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: myYellow,
              ),
              child: IconButton(
                color: myBlue,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: myBlue,
        actions: [
          Image.asset('assets/outlinedLogo.png'),
          const SizedBox(width: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: myYellow,
        child: const Icon(
          Icons.add,
          size: 50,
          color: myBlue,
        ),
        onPressed: () {
          addTache();
        },
      ),
      backgroundColor: myBlue,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            //Buttons
            Row(
              children: [
                TextButton(
                  style:
                      myBottomStyle(enCours == true ? myYellow : Colors.white),
                  onPressed: () {
                    setState(() {
                      enCours = true;
                    });
                  },
                  child: Text(
                    'En cours',
                    style: TextStyle(
                      color: enCours! ? Colors.white : myBlue,
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  style:
                      myBottomStyle(enCours == false ? myYellow : Colors.white),
                  onPressed: () {
                    setState(() {
                      enCours = false;
                    });
                  },
                  child: Text(
                    'Terminé',
                    style: TextStyle(
                      color: enCours! == false ? Colors.white : myBlue,
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: enCours!
                  ?
                  //affichage taches encours
                  _listTachesEncours.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas des taches en cours maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _listTachesEncours.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              _listTachesEncours[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                  :
                  //affichage taches termine
                  _listTachesTermine.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas des chantiers en terminé maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _listTachesTermine.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              _listTachesTermine[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
