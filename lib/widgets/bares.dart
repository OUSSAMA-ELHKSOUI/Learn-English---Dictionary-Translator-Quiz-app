import 'package:learnenglish_dtmwordswithquiz/screens/manage_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bares extends StatelessWidget {
  final Color color;

  Bares(this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManageWords(),
          ),
        );
      },
      child: Icon(
        FontAwesomeIcons.bars,
        color: color,
        size: 27,
      ),
    );
  }
}
