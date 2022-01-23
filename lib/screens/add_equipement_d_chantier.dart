import 'dart:convert';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/equipement.dart';
import 'package:chantech/screens/equipement_detaille.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEquipementDansChantier extends StatefulWidget {
  final Function update;
  final int idChantier;
  AddEquipementDansChantier(
      {Key? key, required this.update, required this.idChantier})
      : super(key: key);

  @override
  _AddEquipementDansChantierState createState() =>
      _AddEquipementDansChantierState();
}

class _AddEquipementDansChantierState extends State<AddEquipementDansChantier> {
  List<EquipementCard> _listEquipement = [];
  Future<void> fetchEquipements() async {
    _listEquipement = [];
    final response =
        await http.get(Uri.parse(localhost + 'equipement/disponible'));

    if (response.statusCode == 200) {
      final List _listData = jsonDecode(response.body)['data']
          .map((data) => Equipement.fromJson(data))
          .toList();
      setState(
        () {
          for (Equipement e in _listData) {
            _listEquipement.add(
              EquipementCard.fromEquipement(
                e,
                () async {
                  final addOuvrierUrl = localhost +
                      'equipement/numEquipement/${e.numEquipement}/chantier/${widget.idChantier}/nbArticle/1';
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEquipements();
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

            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _listEquipement.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    _listEquipement[index],
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
