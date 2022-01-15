import 'dart:convert';

import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_ouvrier.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OuvrierDetaille extends StatefulWidget {
  final int id;
  const OuvrierDetaille({Key? key, required this.id}) : super(key: key);

  @override
  _OuvrierDetailleState createState() => _OuvrierDetailleState();
}

class _OuvrierDetailleState extends State<OuvrierDetaille> {
  void showEditOuvrier() {
    showDialog(
      context: context,
      builder: (context) {
        return EditOuvrier();
      },
    );
  }

  void showDeleteOuvrier() {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la supression',
        action: () async {
          // final urlSetTerminerChantier =
          //     localhost + 'chantier/setFermer/idChantier/${widget.id}';
          // await http.post(Uri.parse(urlSetTerminerChantier));
          Navigator.pop(context);
        },
      ),
    );
  }

  Ouvrier? _ouvrier = null;

  Future<void> fetchOuvrier() async {
    final response =
        await http.get(Uri.parse(localhost + 'ouvrier/info/id/${widget.id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 200) {
        setState(() {
          _ouvrier = Ouvrier.fromJson(data['data'][0]);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOuvrier();
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
                onPressed: () {
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
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            height: 350,
            child: DescriptOuvrier(
              delete: showDeleteOuvrier,
              edit: showEditOuvrier,
              prenom: _ouvrier == null ? "" : _ouvrier!.prenom,
              id: widget.id,
              nom: _ouvrier == null ? "" : _ouvrier!.nom,
              spec: _ouvrier == null ? "" : _ouvrier!.spec,
              email: _ouvrier == null ? "" : _ouvrier!.email,
              heures: _ouvrier == null
                  ? 0
                  : _ouvrier!.heure == null
                      ? 0
                      : _ouvrier!.heure!,
              numTele: _ouvrier == null ? 0 : _ouvrier!.numero,
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
