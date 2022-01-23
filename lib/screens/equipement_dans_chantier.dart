import 'dart:convert';
import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/equipement.dart';
import 'package:chantech/screens/add_equipement_d_chantier.dart';
import 'package:chantech/screens/equipement_detaille.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipementDansChantier extends StatefulWidget {
  final int idChantier;
  const EquipementDansChantier({Key? key, required this.idChantier})
      : super(key: key);

  @override
  EquipementDansChantierState createState() => EquipementDansChantierState();
}

class EquipementDansChantierState extends State<EquipementDansChantier> {
  List<EquipementCard> _listEquipement = [];
  Future<void> fetchEquipements() async {
    _listEquipement = [];
    final response = await http.get(Uri.parse(
        localhost + 'chantier/idChantier/${widget.idChantier}/equipement'));
    print(response.body);
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
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquipementDetaille(
                        numero: e.numEquipement,
                        update: fetchEquipements,
                      ),
                    ),
                  ),
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
      backgroundColor: myBlue,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEquipementDansChantier(
                        update: fetchEquipements,
                        idChantier: widget.idChantier,
                      )));
        },
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 18),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Equipements disponibles dans ce chantier :',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 450,
              child: _listEquipement.isEmpty
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
