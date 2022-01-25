import 'dart:convert';

import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/components/ouvrier_d_chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/screens/add_ouvrier_d_chantier.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OuvrierDansChantier extends StatefulWidget {
  final int idChantier;
  final int? idRespo;
  const OuvrierDansChantier(
      {Key? key, required this.idChantier, required this.idRespo})
      : super(key: key);

  @override
  OuvrierDansChantierState createState() => OuvrierDansChantierState();
}

class OuvrierDansChantierState extends State<OuvrierDansChantier> {
  List<OuvrierCard> _listOuvriers = [];
  Ouvrier? _respo = null;
  Future<void> fetchRespo() async {
    final response = await http
        .get(Uri.parse(localhost + 'ouvrier/info/id/${widget.idRespo}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 200) {
        setState(() {
          try {
            _respo = Ouvrier.fromJson(data['data'][0]);
          } catch (e) {}
        });
      }
    }
  }

  Future<void> fetchOuvriers() async {
    _listOuvriers = [];
    final response = await http
        .get(Uri.parse(localhost + 'ouvrier/idChantier/${widget.idChantier}'));

    if (response.statusCode == 200) {
      final List _listData = jsonDecode(response.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      setState(
        () {
          for (Ouvrier e in _listData) {
            _listOuvriers.add(
              OuvrierCard.fromOuvrier(
                e,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => OuvrierDetaille(
                        id: e.id,
                        update: fetchOuvriers,
                      ),
                    ),
                  );
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
    fetchOuvriers();
    fetchRespo();
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
      floatingActionButton: (IsAdmin! || IsResp!)
          ? FloatingActionButton(
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
                        update: fetchOuvriers,
                        dejaDansChantier: _listOuvriers,
                      ),
                    ));
              },
            )
          : null,
      body: Container(
        margin: const EdgeInsets.only(top: 18),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Responsable du ce Chantier :',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            OuvrierDChantierCard(
              update: fetchRespo,
              idChantier: widget.idChantier,
              idOuvrier: _respo == null ? 0 : _respo!.id,
              nom: _respo == null ? '/' : _respo!.nom,
              prenom: _respo == null ? '/' : _respo!.prenom,
              spec: _respo == null ? '/' : _respo!.spec,
            ),
            const SizedBox(height: 10),
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
              height: 290,
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
