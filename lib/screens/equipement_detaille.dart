import 'dart:convert';

import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_equipement.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/equipement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipementDetaille extends StatefulWidget {
  final int numero;
  final Function update;
  const EquipementDetaille(
      {Key? key, required this.numero, required this.update})
      : super(key: key);

  @override
  _EquipementDetailleState createState() => _EquipementDetailleState();
}

class _EquipementDetailleState extends State<EquipementDetaille> {
  void showEditEquipement() {
    showDialog(
      context: context,
      builder: (context) {
        return EditEquipement(
          numEquip: widget.numero,
          update: fetchEquipement,
        );
      },
    );
  }

  void showDeleteEquipement() {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la supression',
        action: () async {
          final urlSetTerminerChantier =
              localhost + 'equipement/id/${equipement!.idEquipement}';
          await http.delete(Uri.parse(urlSetTerminerChantier));
          Navigator.pop(context);
        },
      ),
    );
  }

  Equipement? equipement;
  Future<void> fetchEquipement() async {
    final response = await http.get(
        Uri.parse(localhost + 'equipement/numEquipement/${widget.numero}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(widget.numero);

      if (data['status'] == 200) {
        setState(() {
          try {
            equipement = Equipement.fromJson(data['data'][0]);
          } catch (e) {}
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEquipement();
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
                onPressed: () async {
                  await widget.update();
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: SizedBox(
            height: 350,
            child: DescriptEquipement(
              delete: showDeleteEquipement,
              edit: showEditEquipement,
              libelle: equipement != null ? equipement!.libele : '/',
              nbDisp: equipement != null ? equipement!.nb_echantillon : 0,
              num: equipement != null ? equipement!.numEquipement : 0,
              prix: equipement != null ? equipement!.prix.toDouble() : 0,
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptEquipement extends StatefulWidget {
  final String libelle;
  final int num;
  final double prix;
  final int nbDisp;

  final Function edit;
  final Function delete;

  const DescriptEquipement({
    Key? key,
    required this.nbDisp,
    required this.edit,
    required this.delete,
    required this.libelle,
    required this.num,
    required this.prix,
  }) : super(key: key);

  @override
  State<DescriptEquipement> createState() => _DescriptEquipementState();
}

class _DescriptEquipementState extends State<DescriptEquipement> {
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
              const Align(
                child: Icon(
                  Icons.construction,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Text(
                'Libellé : ${widget.libelle}',
                textAlign: TextAlign.left,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Prix de vente : ${widget.prix}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Numéro : ${widget.num}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Nombre des unités disponible : ${widget.nbDisp}',
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
