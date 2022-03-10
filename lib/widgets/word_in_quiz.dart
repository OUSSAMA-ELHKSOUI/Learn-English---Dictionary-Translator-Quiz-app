import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WordInQuiz extends StatelessWidget {
  final String word;
  final String fromWhere;
  final bool isChecked;
  final Function changeTriggerCheckbox;

  WordInQuiz(
      {this.word, this.fromWhere, this.isChecked, this.changeTriggerCheckbox});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        dense: true,
        title: Text(
          word,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Carme',
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          fromWhere,
          style: TextStyle(fontSize: 12, fontFamily: 'Carme'),
        ),
        trailing: GestureDetector(
          onTap: changeTriggerCheckbox,
          child: Icon(
            isChecked ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
            size: 20,
            color: isChecked ? Colors.yellow : Colors.black,
          ),
        ) /*Icon(
          FontAwesomeIcons.volumeUp,
          size: 20,
        )*/
        ,
      ),
    );
  }
}
