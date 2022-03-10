import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final Function function;
  final String text;
  final bool isCheckedCard;
  final bool matchFalse;
  final Color colorBG;
  final Color colorBorder;
  final Color colorText;

  MatchCard(
      {this.function,
      this.text,
      this.isCheckedCard,
      this.matchFalse,
      this.colorBG,
      this.colorBorder,
      this.colorText});

  Color changeColorBG() {
    if (!isCheckedCard) {
      return colorBG;
    } else if (matchFalse) {
      return Colors.redAccent;
    } else {
      return Colors.greenAccent;
    }
  }

  String textS(String text) {
    List<String> words = text.split(' ');
    String textS = '';
    if (words.length < 30) {
      for (int i = 0; i < words.length; i++) {
        textS += '${words[i]} ';
      }
      return textS;
    }
    for (int i = 0; i < 30; i++) {
      textS += '${words[i]} ';
    }
    return '$textS...';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Padding(
          padding: EdgeInsets.only(bottom: 3, right: 3),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: !isCheckedCard && !matchFalse
                      ? colorBorder
                      : kBackGroundDicColor,
                  width: 2),
              color: changeColorBG(),
            ),
            child: Text(
              textS(text),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: !isCheckedCard && !matchFalse
                    ? colorText
                    : kBackGroundDicColor,
                fontFamily: 'Carme',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
