import 'package:chantech/components/add_ouvrier.dart';
import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';

class AllOuvriers extends StatefulWidget {
  List<OuvrierCard> listOuvriersDispo;
  List<OuvrierCard> listOuvriersOcup;
  Function update;
  AllOuvriers({
    Key? key,
    required this.listOuvriersDispo,
    required this.listOuvriersOcup,
    required this.update,
  }) : super(key: key);

  @override
  _AllOuvriersState createState() => _AllOuvriersState();
}

class _AllOuvriersState extends State<AllOuvriers> {
  // void updateList(Ouvrier e) {
  //   setState(() {
  //     widget.listOuvriersDispo.add(OuvrierCard.fromOuvrier(e));
  //   });
  // }

  void addOuvrier() {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AddOuvrier(
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
          'List des ouvrier',
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
          addOuvrier();
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
                    'Occupé',
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
                  widget.listOuvriersDispo.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas d\'ouvrier disponible maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.listOuvriersDispo.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listOuvriersDispo[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                  :
                  //affichage ouvrier Occupe
                  widget.listOuvriersOcup.isEmpty
                      ? const Center(
                          child: Text(
                            'il n\'a pas d\'ouvrier occupé maintenent',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.listOuvriersOcup.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              widget.listOuvriersOcup[index],
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
