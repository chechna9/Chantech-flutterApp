import 'package:chantech/components/confirm_delete.dart';
import 'package:chantech/components/edit_chantier.dart';
import 'package:chantech/components/edit_equipement.dart';
import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class EquipementDetaille extends StatefulWidget {
  const EquipementDetaille({Key? key}) : super(key: key);

  @override
  _EquipementDetailleState createState() => _EquipementDetailleState();
}

class _EquipementDetailleState extends State<EquipementDetaille> {
  void showEditEquipement() {
    showDialog(
      context: context,
      builder: (context) {
        return EditEquipement();
      },
    );
  }

  void showDeleteEquipement() {
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

  String libelle = "Marteau";
  String num = "12";
  double prix = 1500;
  int nbTot = 30;
  int nbOcupe = 12;
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
        child: Center(
          child: SizedBox(
            height: 350,
            child: DescriptEquipement(
              delete: showDeleteEquipement,
              edit: showEditEquipement,
              libelle: libelle,
              nbOcupe: nbOcupe,
              nbTot: nbTot,
              num: num,
              prix: prix,
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptEquipement extends StatefulWidget {
  final String libelle;
  final String num;
  final double prix;
  final int nbTot;
  final int nbOcupe;
  final Function edit;
  final Function delete;

  const DescriptEquipement(
      {Key? key,
      required this.edit,
      required this.delete,
      required this.libelle,
      required this.num,
      required this.prix,
      required this.nbTot,
      required this.nbOcupe})
      : super(key: key);

  @override
  State<DescriptEquipement> createState() => _DescriptEquipementState();
}

class _DescriptEquipementState extends State<DescriptEquipement> {
  int nbDisponible = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nbDisponible = widget.nbTot - widget.nbOcupe;
  }

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
                'Nombre totale des unités : ${widget.nbTot}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Disponible : ${nbDisponible}',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Ocuppé : ${widget.nbOcupe}',
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
