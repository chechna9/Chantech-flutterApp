import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: myYellow,
      title: const Text(
        'Confirmer la supression',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
      content: Row(
        children: [
          Expanded(
            child: TextButton(
              style: myBottomStyle(Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Non',
                style: TextStyle(
                    color: myBlue, fontWeight: FontWeight.w900, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton(
              style: myBottomStyle(myBlue),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Oui',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
