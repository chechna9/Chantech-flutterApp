import 'dart:convert';

import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/components/ouvrier_card_d_tache.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOuvrierDTache extends StatefulWidget {
  final int idChantier;
  final int idTache;
  AddOuvrierDTache({Key? key, required this.idChantier, required this.idTache})
      : super(key: key);

  @override
  _AddOuvrierDTacheState createState() => _AddOuvrierDTacheState();
}

class _AddOuvrierDTacheState extends State<AddOuvrierDTache> {
  List<OuvrierDTache> listOuvriersDispo = [];
  List<OuvrierDTache> listOuvriersOcup = [];
  Future<void> fetchOuvriers() async {
    List<OuvrierDTache> listOuvriersDispo = [];
    List<OuvrierDTache> listOuvriersOcup = [];
    final responseDispo = await http
        .get(Uri.parse(localhost + 'chantier/id/${widget.idChantier}/libre'));
    final responseOcup = await http
        .get(Uri.parse(localhost + 'chantier/id/${widget.idChantier}/occupe'));
    //getting ouvrier disponible
    if (responseDispo.statusCode == 200) {
      final List _listData = jsonDecode(responseDispo.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      setState(() {
        for (Ouvrier e in _listData) {
          listOuvriersDispo
              .add(OuvrierDTache.fromOuvrier(e, widget.idTache, fetchOuvriers));
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
          listOuvriersOcup
              .add(OuvrierDTache.fromOuvrier(e, widget.idTache, fetchOuvriers));
        }
      });
    }
  }

  bool? disponible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOuvriers();
    disponible = true;
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
                  listOuvriersDispo.isEmpty
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
                          itemCount: listOuvriersDispo.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              listOuvriersDispo[index],
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                  :
                  //affichage ouvrier Occupe
                  listOuvriersOcup.isEmpty
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
                          itemCount: listOuvriersOcup.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              listOuvriersOcup[index],
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
