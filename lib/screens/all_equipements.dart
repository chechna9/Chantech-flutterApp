import 'package:chantech/components/add_equipement.dart';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllEquipements extends StatefulWidget {
  List<EquipementCard> listEquipementsDispo;
  List<EquipementCard> listEquipementsOcup;
  final Function update;
  AllEquipements({
    Key? key,
    required this.listEquipementsDispo,
    required this.listEquipementsOcup,
    required this.update,
  }) : super(key: key);

  @override
  _AllEquipementsState createState() => _AllEquipementsState();
}

class _AllEquipementsState extends State<AllEquipements> {
  void addEquipement() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AddEquipement(
          update: widget.update,
        );
      },
    );
  }

  bool? disponible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disponible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: myBlue,
        title: const Text(
          'List des equipements',
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
          addEquipement();
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
                  style: myBottomStyle(
                      disponible == true ? myYellow : Colors.white),
                  onPressed: () {
                    setState(() {
                      disponible = true;
                    });
                  },
                  child: Text(
                    'Disponible',
                    style: TextStyle(
                      color: disponible! ? Colors.white : myBlue,
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: myBottomStyle(
                      disponible == false ? myYellow : Colors.white),
                  onPressed: () {
                    setState(() {
                      disponible = false;
                    });
                  },
                  child: Text(
                    'Ocuppé',
                    style: TextStyle(
                      color: disponible! == false ? Colors.white : myBlue,
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
              child: disponible!
                  ?
                  //affichage ouvrier diponible
                  widget.listEquipementsDispo.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas d\'equipement disponible maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.listEquipementsDispo.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listEquipementsDispo[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                  :
                  //affichage ouvrier Occupe
                  widget.listEquipementsOcup.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas d\'equipement occupé maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.listEquipementsOcup.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listEquipementsOcup[index],
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
