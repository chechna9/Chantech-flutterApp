import 'package:chantech/components/add_chantier.dart';
import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllChantiers extends StatefulWidget {
  List<ChantierCard> listChantiers;
  AllChantiers({Key? key, required this.listChantiers}) : super(key: key);

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
          listChantiers: widget.listChantiers,
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
        title: Text(
          'List des chantiers',
          style: const TextStyle(
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
              child: ListView.builder(
                itemCount: widget.listChantiers.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    widget.listChantiers[index],
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
