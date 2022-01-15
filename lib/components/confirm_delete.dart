import 'package:chantech/consts.dart';
import 'package:flutter/material.dart';

class ConfirmAction extends StatelessWidget {
  final Function action;
  final String title;
  const ConfirmAction({Key? key, required this.action, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: myYellow,
      title: Text(
        title,
        style: const TextStyle(
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
                  color: myBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextButton(
              style: myBottomStyle(myBlue),
              onPressed: () => action(),
              child: const Text(
                'Oui',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
