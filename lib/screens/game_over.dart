import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/button_app.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/done_remain_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final Function function;
  final int numberWord;
  final int firstTry;

  GameOver({this.function, this.numberWord, this.firstTry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackGroundDicColor,
        appBar: AppBar(
          backgroundColor: kBackGroundDicColor,
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 10),
          //     child: Bares(kBlue),
          //   ),
          // ],
          leading: BackArrow(
            color: kBlue,
            function: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
              ),
              Column(
                children: [
                  Text(
                    'Quiz over',
                    style: TextStyle(fontSize: 25, fontFamily: 'Carme'),
                  ),
                  //SizedBox(height: 5),
                  Text('Your score is $firstTry/$numberWord',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Carme',
                        fontWeight: FontWeight.w900,
                      )),
                  SizedBox(height: 15),
                  ButtonApp(
                    textChild: 'Play again',
                    minWidth: 400,
                    onPress: function,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Text(
                    'You got $firstTry out of $numberWord correct on the first attempt',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontFamily: 'Carme')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
