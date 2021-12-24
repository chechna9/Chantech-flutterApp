import 'package:chantech/components/equipement_card.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class AllEquipements extends StatefulWidget {
  List<EquipementCard> listEquipements;
  AllEquipements({Key? key, required this.listEquipements}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: myBlue,
        title: Text(
          'List des ouvriers',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
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
              child: ListView.builder(
                itemCount: widget.listEquipements.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    widget.listEquipements[index],
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
