import 'dart:convert';

import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/components/ouvrier_d_chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/screens/add_ouvrier_d_chantier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OuvrierDansChantier extends StatefulWidget {
  final int idChantier;
  const OuvrierDansChantier({Key? key, required this.idChantier})
      : super(key: key);

  @override
  OuvrierDansChantierState createState() => OuvrierDansChantierState();
}

class OuvrierDansChantierState extends State<OuvrierDansChantier> {
  List<OuvrierCard> _listOuvriers = [];
  Future<void> fetchOuvriers() async {
    final response = await http
        .get(Uri.parse(localhost + 'ouvrier/idChantier/${widget.idChantier}'));
    print(response.body);
    if (response.statusCode == 200) {
      final List _listData = jsonDecode(response.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      setState(() {
        for (Ouvrier e in _listData) {
          _listOuvriers.add(OuvrierCard.fromOuvrier(e));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOuvriers();
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
                builder: (context) => AddOuvrierDChantier(
                  idChantier: widget.idChantier,
                ),
              ));
        },
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 18),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ouvriers disponibles dans ce chantier :',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 450,
              child: ListView.builder(
                itemCount: _listOuvriers.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    _listOuvriers[index],
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
