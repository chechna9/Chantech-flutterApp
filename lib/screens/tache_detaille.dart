import 'dart:convert';

import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_tache.dart';
import 'package:chantech/components/ouvrier_card.dart';
import 'package:chantech/consts.dart';
import 'package:chantech/models/tache.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TacheDetaille extends StatefulWidget {
  final int id;
  const TacheDetaille({Key? key, required this.id}) : super(key: key);

  @override
  _TacheDetailleState createState() => _TacheDetailleState();
}

class _TacheDetailleState extends State<TacheDetaille> {
  void showEditTache() {
    showDialog(
      context: context,
      builder: (context) {
        return EditTache();
      },
    );
  }

  void showDeleteTache() {
    showDialog(
      context: context,
      builder: (context) => const ConfirmDelete(),
    );
  }

  List<OuvrierCard> _listOuvriers = [];

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
        onPressed: () {},
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
              delete: showDeleteTache,
              edit: showEditTache,
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
              child: ListView.builder(
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
  final Function edit;
  final Function delete;
  const DescriptTache(
      {Key? key,
      required this.nom,
      required this.descript,
      required this.id,
      required this.dure,
      required this.edit,
      required this.delete})
      : super(key: key);

  @override
  State<DescriptTache> createState() => _DescriptTacheState();
}

class _DescriptTacheState extends State<DescriptTache> {
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
