import 'package:chantech/consts.dart';
import 'package:chantech/screens/all_chantiers.dart';
import 'package:chantech/screens/all_ouvriers.dart';
import 'package:flutter/material.dart';

List<String> titles = [
  'List des chantiers',
  'List des ouvriers',
  'List des equipements',
];
int? index;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: myBlue,
        title: Text(
          titles[index!],
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
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: myYellow,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
              icon: Icon(
                Icons.house_rounded,
                color: index == 0 ? myBlue : Colors.white,
                size: index == 0 ? 35 : 30,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
              icon: Icon(
                Icons.person,
                color: index == 1 ? myBlue : Colors.white,
                size: index == 1 ? 35 : 30,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
              icon: Icon(
                Icons.construction,
                color: index == 2 ? myBlue : Colors.white,
                size: index == 2 ? 35 : 30,
              ),
            ),
          ],
        ),
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
      body: AllOuvriers(),
    );
  }
}
