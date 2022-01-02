import 'package:chantech/components/add_chantier.dart';
import 'package:chantech/components/add_tache.dart';
import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/components/tache_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/screens/home.dart';
import 'package:flutter/material.dart';

class AllTaches extends StatefulWidget {
  // List<ChantierCard> listChantiers;
  AllTaches({Key? key}) : super(key: key);

  @override
  _AllTachesState createState() => _AllTachesState();
}

class _AllTachesState extends State<AllTaches> {
  List<TacheCard> _listTaches = [
    TacheCard(nom: 'plat forme', dure: 40),
    TacheCard(nom: 'plat forme', dure: 40),
    TacheCard(nom: 'plat forme', dure: 40),
  ];
  void addTache() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AddTache();
      },
    );
  }

  bool? enCours;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                onPressed: () {},
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
              child: ListView.builder(
                itemCount: _listTaches.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    _listTaches[index],
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
