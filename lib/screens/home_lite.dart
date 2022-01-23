import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/chantier.dart';
import 'package:chantech/var_glob.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeLite extends StatefulWidget {
  const HomeLite({Key? key}) : super(key: key);

  @override
  _HomeLiteState createState() => _HomeLiteState();
}

class _HomeLiteState extends State<HomeLite> {
  List<ChantierCard> listChantiers = [];
  Future<void> fetchChantiers() async {
    listChantiers = [];
    final response = IsResp!
        ? await http.get(Uri.parse(urlResponsable))
        : IsProp!
            ? await http.get(Uri.parse(urlProp))
            : await http.get(Uri.parse(urlOuv));

    if (response.statusCode == 200) {
      print(response.body);
      final List _listData = jsonDecode(response.body)['data']
          .map((data) => Chantier.fromJson(data))
          .toList();
      print(response.body);
      setState(() {
        for (Chantier e in _listData) {
          listChantiers.add(ChantierCard.fromChantier(e, fetchChantiers));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChantiers();
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
      backgroundColor: myBlue,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            //Buttons

            const SizedBox(height: 10),
            SizedBox(
                height: 400,
                child:
                    //affichage chantier encours
                    listChantiers.isEmpty
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
                            itemCount: listChantiers.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                listChantiers[index],
                                const SizedBox(height: 10),
                              ],
                            ),
                          )),
          ],
        ),
      ),
    );
  }
}
