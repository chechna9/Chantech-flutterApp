import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditEquipement extends StatelessWidget {
  final int numEquip;
  final Function update;
  EditEquipement({
    Key? key,
    required this.numEquip,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    int quant = 0;
    int prix = 0;
    return Scaffold(
      backgroundColor: const Color(0x44ffffff),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 120, 40, 0),
        child: Container(
          decoration: const BoxDecoration(
              color: myYellow,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Prix de vent
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    decoration: myTFFDecoration('Prix de vent'),
                    onChanged: (value) => prix = int.parse(value),
                    validator: (val) =>
                        val!.isEmpty ? 'Remplir ce champ' : null,
                  ),
                  const SizedBox(height: 20),
                  //quantité
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    decoration: myTFFDecoration('Quantitée'),
                    onChanged: (value) => quant = int.parse(value),
                    validator: (val) =>
                        val!.isEmpty ? 'Remplir ce champ' : null,
                  ),

                  const SizedBox(height: 40),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: myBottomStyle(Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                                color: myBlue,
                                fontWeight: FontWeight.w900,
                                fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          style: myBottomStyle(myBlue),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              final editEquipementUrl = localhost +
                                  'equipement/numEquipement/$numEquip/nbArticle/$quant/prix/$prix';
                              await http.put(Uri.parse(editEquipementUrl));
                              await update();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Modifier',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
