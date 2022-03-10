import 'dart:math';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/button_app.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/done_remain_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_over.dart';

class QuizWrite extends StatefulWidget {
  @override
  _QuizWriteState createState() => _QuizWriteState();
}

class _QuizWriteState extends State<QuizWrite> {
  Random random;
  List list;
  int firstTry;
  List<int> randomIntegersList = [];

  int randomDef;

  int indexRandomInt = 0;

  String answer = '';

  Widget _bottomSheet;

  TextEditingController textEditingController = TextEditingController();

  int done = 0;
  bool firstTryCheck = true;

  @override
  void initState() {
    super.initState();
    random = Random();

    list = Provider.of<ValueManager>(context, listen: false).allWordChecked
        ? Provider.of<ValueManager>(context, listen: false)
            .dictionaryTranslatorDataList
        : Provider.of<ValueManager>(context, listen: false)
            .dictionaryTranslatorDataListChecked;

    firstTry = list.length;

    List<int> integersList = [];
    int a = 0;
    for (int i = 0; i < list.length; i++) {
      integersList.add(a++);
    }

    randomIntegersList = [];
    for (int i = 0; i < list.length; i++) {
      int number = random.nextInt(integersList.length);
      randomIntegersList.add(integersList[number]);
      integersList.remove(integersList[number]);
    }
    randomDef = random.nextInt(list[randomIntegersList[indexRandomInt]]
        .definitionOrTranslation
        .length);

    _bottomSheet = BSheet(
      controller: textEditingController,
      function: (value) {
        answer = value;
        Provider.of<ValueManager>(context, listen: false)
            .changeCheckAnswer(false);
      },
      functionButton: () {
        if (answer.trimRight().trimLeft().toLowerCase() ==
            list[randomIntegersList[indexRandomInt]].word) {
          answer = '';
          if (indexRandomInt == randomIntegersList.length - 1) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameOver(
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizWrite()));
                  },
                  numberWord: list.length,
                  firstTry: firstTry,
                ),
              ),
            );
          }
          indexRandomInt++;
          done++;
          if (indexRandomInt < randomIntegersList.length)
            randomDef = random.nextInt(list[randomIntegersList[indexRandomInt]]
                .definitionOrTranslation
                .length);
          firstTryCheck = true;
        } else {
          Provider.of<ValueManager>(context, listen: false)
              .changeCheckAnswer(true);
          if (firstTryCheck) {
            firstTryCheck = false;
            firstTry--;
          }
        }
        textEditingController.clear();
      },
    );
  }

  Future<bool> pressBackButton(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'do you want to exit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Carme",
                  fontWeight: FontWeight.w900,
                ),
              ),
              contentPadding: EdgeInsets.all(20),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'yes',
                    style: TextStyle(
                      color: kButtonColor,
                      fontSize: 20,
                      fontFamily: "Carme",
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeCheckAnswer(false);
                  },
                ),
                FlatButton(
                  child: Text(
                    'no',
                    style: TextStyle(
                      color: kButtonColor,
                      fontSize: 20,
                      fontFamily: "Carme",
                      //fontWeight: FontWeight.w900,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => pressBackButton(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackGroundDicColor,
          bottomSheet: _bottomSheet,
          appBar: AppBar(
            backgroundColor: kBackGroundDicColor,
            elevation: 0,
            title: DoneRemainText(
              done: done,
              remain: list.length - done,
            ),
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
                Provider.of<ValueManager>(context, listen: false)
                    .changeCheckAnswer(false);
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 140),
            children: [
              indexRandomInt < list.length
                  ? Text(
                      list[randomIntegersList[indexRandomInt]].fromWhere ==
                              'From Dictionary'
                          ? 'definition or synonyms'.toUpperCase()
                          : 'translation'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(width: double.infinity),
              SizedBox(height: 3),
              indexRandomInt < list.length
                  ? Text(
                      list[randomIntegersList[indexRandomInt]]
                          .definitionOrTranslation[randomDef],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Carme",
                      ),
                    )
                  : Container(width: double.infinity),
              SizedBox(height: 20),
              Provider.of<ValueManager>(context).checkAnswer
                  ? Text(
                      'You answer : ',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? SizedBox(height: 3)
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? Text(
                      answer,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Carme",
                        //fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? SizedBox(height: 3)
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? Text(
                      'correct answer : ',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? SizedBox(height: 3)
                  : Container(width: double.infinity),
              Provider.of<ValueManager>(context).checkAnswer
                  ? Text(
                      list[randomIntegersList[indexRandomInt]].word,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Carme",
                        //fontWeight: FontWeight.w900,
                      ),
                    )
                  : Container(width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}

class BSheet extends StatelessWidget {
  //final List randomIntegersList;
  final Function function;
  final Function functionButton;
  final TextEditingController controller;

  BSheet({this.function, this.functionButton, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 111,
        // padding:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: function,
              decoration: InputDecoration(
                hintText: 'Enter the word',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kButtonColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kButtonColor, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 5),
            ButtonApp(
              textChild: 'Done',
              minWidth: double.infinity,
              onPress: functionButton,
              size: 25,
            )
          ],
        ),
      ),
    );
  }
}
