import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestCard extends StatelessWidget {
  final String word;
  final Function function;
  final bool cardTest;
  TestCard({this.function, this.word, this.cardTest});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: cardTest ? kButtonColor : Colors.redAccent,
            width: 3,
          ),
          color: kBackGroundDicColor,
        ),
        child: Text(
          word,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: kBlue,
            fontFamily: 'Carme',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
