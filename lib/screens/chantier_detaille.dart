import 'dart:convert';
import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_chantier.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/chantier.dart';
import 'package:chantech/screens/all_taches.dart';
import 'package:chantech/screens/equipement_dans_chantier.dart';

import 'package:chantech/screens/ouvrier_dans_chantier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChantierDetaille extends StatefulWidget {
  final int id;

  final Function update;

  ChantierDetaille({
    Key? key,
    required this.id,
    required this.update,
  }) : super(key: key);

  @override
  _ChantierDetailleState createState() => _ChantierDetailleState();
}

class _ChantierDetailleState extends State<ChantierDetaille> {
  void showEditChantier() {
    showDialog(
      context: context,
      builder: (context) {
        return EditChantier(
          idChantier: widget.id,
          update: fetchChantier,
          chantier: _chantier!,
        );
      },
    );
  }

  Chantier? _chantier = null;
  void showDeleteChantier() async {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la supression',
        action: () async {
          final urlDeleteChantier = localhost + 'chantier/id/${widget.id}';
          await http.delete(Uri.parse(urlDeleteChantier));

          Navigator.pop(context);
        },
      ),
    );
  }

  void showDoneChantier() async {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la cloture du chantier',
        action: () async {
          final urlSetTerminerChantier =
              localhost + 'chantier/setFermer/idChantier/${widget.id}';
          await http.put(Uri.parse(urlSetTerminerChantier));

          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> fetchChantier() async {
    final response =
        await http.get(Uri.parse(localhost + 'chantier/info/id/${widget.id}'));
    final heurResponse = await http
        .get(Uri.parse(localhost + 'chantier/id/${widget.id}/travaille'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final heurData = jsonDecode(heurResponse.body);
      if (data['status'] == 200) {
        setState(() {
          heurData['data'][0]['heureTravaillerChantier'] == null
              ? heureTravaille = 0
              : heureTravaille =
                  int.parse(heurData['data'][0]['heureTravaillerChantier']);
          _chantier = Chantier.fromJson(data['data'][0]);
          // print(data['data'][0]);
        });
      }
    }
  }

  int? heureTravaille;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChantier();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DescriptChantier(
              done: showDoneChantier,
              delete: showDeleteChantier,
              edit: showEditChantier,
              adress: _chantier == null ? '/' : _chantier!.address,
              id: _chantier == null ? 0 : _chantier!.idChantier,
              nom: _chantier == null ? '/' : _chantier!.nomChantier,
              prop: _chantier == null
                  ? '/'
                  : '${_chantier!.nomProprietaire} ${_chantier!.preNomProprietaire}',
              respo: _chantier == null
                  ? '/'
                  : '${_chantier!.nomResponsable} ${_chantier!.preNomResponsable}',
              heures: heureTravaille == null ? 0 : heureTravaille!,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: myBottomStyle(myYellow),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllTaches(
                                        id: widget.id,
                                      )));
                        },
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OuvrierDansChantier(
                                        idChantier: widget.id,
                                        idRespo: _chantier == null
                                            ? null
                                            : _chantier!.idResponsable,
                                      )));
                        },
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EquipementDansChantier(
                                idChantier: widget.id,
                              ),
                            ),
                          );
                        },
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
  final String adress;
  final int heures;
  final Function edit;
  final Function delete;
  final Function done;
  const DescriptChantier(
      {Key? key,
      required this.nom,
      this.respo: '/',
      required this.prop,
      required this.id,
      required this.heures,
      required this.adress,
      required this.edit,
      required this.done,
      required this.delete})
      : super(key: key);

  @override
  State<DescriptChantier> createState() => _DescriptChantierState();
}

class _DescriptChantierState extends State<DescriptChantier> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: myYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
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
            bottom: -20,
            right: 0,
            child: IconButton(
              onPressed: () {
                widget.delete();
              },
              icon: const Icon(
                Icons.delete,
                color: myBlue,
                size: 35,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: 0,
            child: IconButton(
              onPressed: () {
                widget.done();
              },
              icon: const Icon(
                Icons.cloud_done,
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
                'Adresse : ${widget.adress}',
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
