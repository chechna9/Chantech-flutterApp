import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_ouvrier.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class OuvrierDetaille extends StatefulWidget {
  const OuvrierDetaille({Key? key}) : super(key: key);

  @override
  _OuvrierDetailleState createState() => _OuvrierDetailleState();
}

class _OuvrierDetailleState extends State<OuvrierDetaille> {
  void showEditChantier() {
    showDialog(
      context: context,
      builder: (context) {
        return EditOuvrier();
      },
    );
  }

  void showDeleteChantier() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDelete(),
    );
  }

  int id = 01;
  int heures = 112;
  String nom = "Aboud";
  String prenom = "Seyi";
  String spec = "Plombier";
  int numTele = 0775093097;
  String email = "SeyiAboud@gmail.com";
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            height: 350,
            child: DescriptOuvrier(
              delete: showDeleteChantier,
              edit: showEditChantier,
              prenom: prenom,
              id: id,
              nom: nom,
              spec: spec,
              email: email,
              heures: heures,
              numTele: numTele,
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptOuvrier extends StatefulWidget {
  final String nom;
  final String prenom;
  final int id;
  final String spec;
  final int numTele;
  final int heures;
  final String email;
  final Function edit;
  final Function delete;
  const DescriptOuvrier(
      {Key? key,
      required this.nom,
      required this.edit,
      required this.delete,
      required this.prenom,
      required this.spec,
      required this.id,
      required this.heures,
      required this.numTele,
      required this.email})
      : super(key: key);

  @override
  State<DescriptOuvrier> createState() => _DescriptOuvrierState();
}

class _DescriptOuvrierState extends State<DescriptOuvrier> {
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
                  Icons.person,
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
                'Prénom : ${widget.prenom}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'ID : ${widget.id}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Specialité : ${widget.spec}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Numéro de Telephone : ${widget.numTele}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'E-mail : ${widget.email}',
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
            ],
          ),
        ],
      ),
    );
  }
}
