import 'package:chantech/components/chantier_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllChantiers extends StatefulWidget {
  const AllChantiers({Key? key}) : super(key: key);

  @override
  _AllChantiersState createState() => _AllChantiersState();
}

class _AllChantiersState extends State<AllChantiers> {
  bool? enCours;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enCours = true;
  }

  List<ChantierCard> listChantiers = [
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
    ChantierCard(
      nom: 'La tour Eiffel',
      respo: 'Aboud',
      prop: 'Rachid Nekaz',
    ),
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
                style: myBottomStyle(enCours == true ? myYellow : Colors.white),
                onPressed: () {
                  setState(() {
                    enCours = true;
                  });
                },
                child: Text(
                  'En cours',
                  style: TextStyle(
                    color: enCours! ? Colors.white : myBlue,
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                style:
                    myBottomStyle(enCours == false ? myYellow : Colors.white),
                onPressed: () {
                  setState(() {
                    enCours = false;
                  });
                },
                child: Text(
                  'Terminé',
                  style: TextStyle(
                    color: enCours! == false ? Colors.white : myBlue,
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
              itemCount: listChantiers.length,
              itemBuilder: (context, index) => Column(
                children: [
                  listChantiers[index],
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
