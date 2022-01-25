import 'dart:convert';

import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOuvrierDChantier extends StatefulWidget {
  final int idChantier;
  final Function update;
  final List<OuvrierCard> dejaDansChantier;
  AddOuvrierDChantier(
      {Key? key,
      required this.idChantier,
      required this.update,
      required this.dejaDansChantier})
      : super(key: key);

  @override
  _AddOuvrierDChantierState createState() => _AddOuvrierDChantierState();
}

class _AddOuvrierDChantierState extends State<AddOuvrierDChantier> {
  List<OuvrierCard> listOuvriersDispo = [];
  List<OuvrierCard> listOuvriersOcup = [];
  Future<void> fetchOuvriers() async {
    listOuvriersDispo = [];
    listOuvriersOcup = [];
    final responseDispo = await http.get(Uri.parse(urlOuvrierDispo));
    final responseOcup = await http.get(Uri.parse(urlOuvrierOcup));
    //getting ouvrier disponible
    if (responseDispo.statusCode == 200) {
      final List _listData = jsonDecode(responseDispo.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      // _listData.removeWhere((e)=>widget.dejaDansChantier.contains(e[]));
      setState(
        () {
          for (Ouvrier e in _listData) {
            listOuvriersDispo.add(
              OuvrierCard.fromOuvrier(
                e,
                () async {
                  final addOuvrierUrl = localhost +
                      'ouvrier/idOuvrier/${e.id}/idChantier/${widget.idChantier}';
                  await http.post(Uri.parse(addOuvrierUrl));
                  await widget.update();
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
      );
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
            () async {
              final addOuvrierUrl = localhost +
                  'ouvrier/idOuvrier/${e.id}/idChantier/${widget.idChantier}';
              await http.post(Uri.parse(addOuvrierUrl));
              await widget.update();
              Navigator.pop(context);
            },
          ));
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
                onPressed: () async {
                  await widget.update();
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
