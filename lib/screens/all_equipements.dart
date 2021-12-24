import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllEquipements extends StatefulWidget {
  const AllEquipements({Key? key}) : super(key: key);

  @override
  _AllEquipementsState createState() => _AllEquipementsState();
}

class _AllEquipementsState extends State<AllEquipements> {
  bool? disponible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disponible = true;
  }

  List<EquipementCard> listEquipements = [
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
    EquipementCard(libelle: 'Marteau', num: 12, rest: 25),
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
              itemCount: listEquipements.length,
              itemBuilder: (context, index) => Column(
                children: [
                  listEquipements[index],
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
