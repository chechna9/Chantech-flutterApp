import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_chantier.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class ChantierDetaille extends StatefulWidget {
  const ChantierDetaille({Key? key}) : super(key: key);

  @override
  _ChantierDetailleState createState() => _ChantierDetailleState();
}

class _ChantierDetailleState extends State<ChantierDetaille> {
  void showEditChantier() {
    showDialog(
      context: context,
      builder: (context) {
        return EditChantier();
      },
    );
  }

  void showDeleteChantier() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDelete(),
    );
  }

  String nom = 'La toure eiffel';
  String respo = 'Seyi Boud';
  String prop = 'Rachid Nekaz';
  int id = 01;
  int dure = 12;
  int heures = 8;
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DescriptChantier(
              delete: showDeleteChantier,
              edit: showEditChantier,
              dure: dure,
              id: id,
              nom: nom,
              prop: prop,
              respo: respo,
              heures: heures,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: myBottomStyle(myYellow),
                        onPressed: () {},
                        child: const Text(
                          'Taches',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: myBottomStyle(myYellow),
                        onPressed: () {},
                        child: const Text(
                          'Ouvriers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: myBottomStyle(myYellow),
                        onPressed: () {},
                        child: const Text(
                          'Equipements',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptChantier extends StatefulWidget {
  final String nom;
  final String respo;
  final String prop;
  final int id;
  final int dure;
  final int heures;
  final Function edit;
  final Function delete;
  const DescriptChantier(
      {Key? key,
      required this.nom,
      this.respo: '/',
      required this.prop,
      required this.id,
      this.heures: 0,
      required this.dure,
      required this.edit,
      required this.delete})
      : super(key: key);

  @override
  State<DescriptChantier> createState() => _DescriptChantierState();
}

class _DescriptChantierState extends State<DescriptChantier> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: myYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                widget.edit();
              },
              icon: const Icon(
                Icons.settings,
                color: myBlue,
                size: 35,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                print('delte');
                widget.delete();
              },
              icon: const Icon(
                Icons.delete,
                color: myBlue,
                size: 35,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: const Icon(
                  Icons.house,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Text(
                'Nom : ${widget.nom}',
                textAlign: TextAlign.left,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Responsable : ${widget.respo}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Proprietaire : ${widget.prop}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Id : ${widget.id}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Duré : ${widget.dure}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Totale des heures travaillées : ${widget.heures}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
