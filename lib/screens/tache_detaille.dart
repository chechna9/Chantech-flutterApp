import 'dart:convert';

import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/ouvrier.dart';
import 'package:chantech/models/tache.dart';
import 'package:chantech/screens/ajout_ouvrier_d_tache.dart';
import 'package:chantech/screens/ouvrier_detaille.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TacheDetaille extends StatefulWidget {
  final int id;

  const TacheDetaille({Key? key, required this.id}) : super(key: key);

  @override
  _TacheDetailleState createState() => _TacheDetailleState();
}

class _TacheDetailleState extends State<TacheDetaille> {
  void showDeleteTache() {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la supression',
        action: () async {
          final urlDeletetache = localhost + 'tache/tacheId/${widget.id}';
          await http.delete(Uri.parse(urlDeletetache));
          Navigator.pop(context);
        },
      ),
    );
  }

  void showDoneTache() {
    showDialog(
      context: context,
      builder: (context) => ConfirmAction(
        title: 'Confirmer la cloture de la tache',
        action: () async {
          final urlSetTerminerTache =
              localhost + 'tache/setTerminer/idTache/${widget.id}';
          await http.put(Uri.parse(urlSetTerminerTache));
          Navigator.pop(context);
        },
      ),
    );
  }

  List<OuvrierCard> _listOuvriers = [];
  Future<void> fetchOuvriers() async {
    final response = await http
        .get(Uri.parse(localhost + 'tache/idTache/${widget.id}/ouvrier'));

    //getting ouvriers de la tache
    if (response.statusCode == 200) {
      final List _listData = jsonDecode(response.body)['data']
          .map((data) => Ouvrier.fromJson(data))
          .toList();
      setState(() {
        for (Ouvrier e in _listData) {
          _listOuvriers.add(OuvrierCard.fromOuvrier(e, () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => OuvrierDetaille(
                  id: e.id,
                  update: fetchOuvriers,
                ),
              ),
            );
          }));
        }
      });
    }
  }

  Tache? _tache;
  Future<void> fetchTache() async {
    final response =
        await http.get(Uri.parse(localhost + 'tache/id/${widget.id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 200) {
        setState(() {
          _tache = Tache.fromJson(data['data'][0]);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTache();
    fetchOuvriers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: myYellow,
        child: const Icon(
          Icons.add,
          size: 50,
          color: myBlue,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddOuvrierDTache(
                  idChantier: _tache!.idChantier,
                  idTache: widget.id,
                ),
              ));
        },
      ),
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
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DescriptTache(
              done: showDoneTache,
              delete: showDeleteTache,
              dure: _tache == null ? 0 : _tache!.duree,
              id: _tache == null ? 0 : _tache!.idTache,
              nom: _tache == null ? '' : _tache!.nom,
              descript: _tache == null ? '' : _tache!.description,
            ),
            const SizedBox(height: 10),
            const Text(
              'Ouvriers qui s\'occupent de cette tache : ',
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _listOuvriers.isEmpty
                  ? const Center(
                      child: Text(
                        'Il n\'y a pas d\'ouvriers affecter pour cette taches',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _listOuvriers.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          _listOuvriers[index],
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptTache extends StatefulWidget {
  final String nom;

  final int id;
  final int dure;
  final String descript;

  final Function delete;
  final Function done;
  const DescriptTache(
      {Key? key,
      required this.done,
      required this.nom,
      required this.descript,
      required this.id,
      required this.dure,
      required this.delete})
      : super(key: key);

  @override
  State<DescriptTache> createState() => _DescriptTacheState();
}

class _DescriptTacheState extends State<DescriptTache> {
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
                  Icons.toc_sharp,
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
                'Id : ${widget.id}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Duré : ${widget.dure} h',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Description : ${widget.descript}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
