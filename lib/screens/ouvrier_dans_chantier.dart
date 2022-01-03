import 'package:chantech/components/ouvrier_d_chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class OuvrierDansChantier extends StatefulWidget {
  const OuvrierDansChantier({Key? key}) : super(key: key);

  @override
  OuvrierDansChantierState createState() => OuvrierDansChantierState();
}

class OuvrierDansChantierState extends State<OuvrierDansChantier> {
  List<OuvrierDChantierCard> _listOuvriers = [
    OuvrierDChantierCard(
        nom: 'aboud', prenom: 'seyi', spec: 'plombier', isChef: true),
    OuvrierDChantierCard(
        nom: 'aboud', prenom: 'seyi', spec: 'plombier', isChef: true),
    OuvrierDChantierCard(
        nom: 'aboud', prenom: 'seyi', spec: 'plombier', isChef: true),
    OuvrierDChantierCard(
        nom: 'aboud', prenom: 'seyi', spec: 'plombier', isChef: true),
  ];
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
                onPressed: () {},
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
        onPressed: () {},
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
