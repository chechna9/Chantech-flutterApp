import 'package:chantech/components/add_chantier.dart';
import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/screens/home.dart';
import 'package:flutter/material.dart';

class AllChantiers extends StatefulWidget {
  List<ChantierCard> listChantiersEnCours;
  List<ChantierCard> listChantiersTerminer;
  final Function update;
  AllChantiers({
    Key? key,
    required this.listChantiersEnCours,
    required this.listChantiersTerminer,
    required this.update,
  }) : super(key: key);

  @override
  _AllChantiersState createState() => _AllChantiersState();
}

class _AllChantiersState extends State<AllChantiers> {
  void addChantier() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AddChantier(
          updateListEncours: listChantiersEnCours,
          updateListTerminer: listChantiersTerminer,
          update: widget.update,
        );
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
        backgroundColor: myBlue,
        title: const Text(
          'List des chantiers',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
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
          addChantier();
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
                  //affichage chantier encours
                  widget.listChantiersEnCours.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas des chantiers en cours maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.listChantiersEnCours.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listChantiersEnCours[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                  :
                  //affichage chantier termine
                  widget.listChantiersTerminer.isEmpty
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
                          itemCount: widget.listChantiersTerminer.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listChantiersTerminer[index],
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
