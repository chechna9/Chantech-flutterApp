import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllOuvriers extends StatefulWidget {
  const AllOuvriers({Key? key}) : super(key: key);

  @override
  _AllOuvriersState createState() => _AllOuvriersState();
}

class _AllOuvriersState extends State<AllOuvriers> {
  bool? disponible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disponible = true;
  }

  List<OuvrierCard> listOuvriers = [
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
    OuvrierCard(nom: 'Aboud', prenom: 'Seyi', spec: 'Plombier'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          //Buttons
          Row(
            children: [
              TextButton(
                style:
                    myBottomStyle(disponible == true ? myYellow : Colors.white),
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
            child: ListView.builder(
              itemCount: listOuvriers.length,
              itemBuilder: (context, index) => Column(
                children: [
                  listOuvriers[index],
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
