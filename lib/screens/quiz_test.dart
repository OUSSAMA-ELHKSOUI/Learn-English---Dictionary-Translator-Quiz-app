import 'dart:math';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/done_remain_text.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/test_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_over.dart';

class QuizTest extends StatefulWidget {
  @override
  _QuizTestState createState() => _QuizTestState();
}

class _QuizTestState extends State<QuizTest> {
  Random random;
  List list;

  List<int> randomIntegersList;
  int randomDef;
  int indexRandomInt = 0;

  List<List<String>> randomWordsList = [];

  int done = 0;

  int firstTry;
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

    for (int i = 0; i < list.length; i++) {
      List<String> randomWords =
          Provider.of<ValueManager>(context, listen: false).randomWords;
      for (int i = 0; i < list.length; i++) {
        if (!randomWords.contains(list[i].word)) {
          randomWords.add(list[i].word);
        }
      }
      List<String> fourWords = [list[randomIntegersList[i]].word];
      for (int i = 0; i < 3; i++) {
        bool a = true;
        while (a) {
          int number = random.nextInt(randomWords.length);
          if (!fourWords.contains(randomWords[number])) {
            fourWords.insert(
                random.nextInt(fourWords.length), randomWords[number]);
            a = false;
          }
        }
      }
      fourWords.remove(list[randomIntegersList[i]].word);
      fourWords.insert(random.nextInt(4), list[randomIntegersList[i]].word);
      randomWordsList.add(fourWords);
    }
  }

  void getProviderMethod(int number) {
    switch (number) {
      case 0:
        Provider.of<ValueManager>(context, listen: false).changeCardTest(false);
        break;
      case 1:
        Provider.of<ValueManager>(context, listen: false)
            .changeCardTest1(false);
        break;
      case 2:
        Provider.of<ValueManager>(context, listen: false)
            .changeCardTest2(false);
        break;
      case 3:
        Provider.of<ValueManager>(context, listen: false)
            .changeCardTest3(false);
        break;
    }
  }

  void onPressTestCard(int index) {
    if (randomWordsList[indexRandomInt][index] ==
        list[randomIntegersList[indexRandomInt]].word) {
      if (indexRandomInt == randomIntegersList.length - 1) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameOver(
              function: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizTest()));
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
      Provider.of<ValueManager>(context, listen: false).changeCardTest(true);
      Provider.of<ValueManager>(context, listen: false).changeCardTest1(true);
      Provider.of<ValueManager>(context, listen: false).changeCardTest2(true);
      Provider.of<ValueManager>(context, listen: false).changeCardTest3(true);
      firstTryCheck = true;
    } else {
      getProviderMethod(index);
      if (firstTryCheck) {
        firstTryCheck = false;
        firstTry--;
      }
    }
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
                    Provider.of<ValueManager>(context, listen: false)
                        .changeCardTest(true);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeCardTest1(true);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeCardTest2(true);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeCardTest3(true);
                    Navigator.pop(context, true);
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

  String textS(String text) {
    List<String> words = text.split(' ');
    String textS = '';
    if (words.length < 4) {
      for (int i = 0; i < words.length; i++) {
        textS += '${words[i]} ';
      }
      return textS;
    }
    for (int i = 0; i < 4; i++) {
      textS += '${words[i]} ';
    }
    return '$textS...';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => pressBackButton(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackGroundDicColor,
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 220,
              child: Column(
                children: [
                  TestCard(
                    function: () => onPressTestCard(0),
                    word: indexRandomInt < list.length
                        ? textS(randomWordsList[indexRandomInt][0])
                        : '',
                    cardTest: Provider.of<ValueManager>(context, listen: false)
                        .cardTest,
                  ),
                  SizedBox(height: 5),
                  TestCard(
                    function: () => onPressTestCard(1),
                    word: indexRandomInt < list.length
                        ? textS(randomWordsList[indexRandomInt][1])
                        : '',
                    cardTest: Provider.of<ValueManager>(context, listen: false)
                        .cardTest1,
                  ),
                  SizedBox(height: 5),
                  TestCard(
                    function: () => onPressTestCard(2),
                    word: indexRandomInt < list.length
                        ? textS(randomWordsList[indexRandomInt][2])
                        : '',
                    cardTest: Provider.of<ValueManager>(context, listen: false)
                        .cardTest2,
                  ),
                  SizedBox(height: 5),
                  TestCard(
                    function: () => onPressTestCard(3),
                    word: indexRandomInt < list.length
                        ? textS(randomWordsList[indexRandomInt][3])
                        : '',
                    cardTest: Provider.of<ValueManager>(context, listen: false)
                        .cardTest3,
                  ),
                ],
              ),
            ),
          ),
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
                Provider.of<ValueManager>(context, listen: false)
                    .changeCardTest(true);
                Provider.of<ValueManager>(context, listen: false)
                    .changeCardTest1(true);
                Provider.of<ValueManager>(context, listen: false)
                    .changeCardTest2(true);
                Provider.of<ValueManager>(context, listen: false)
                    .changeCardTest3(true);
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 250),
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
            ],
          ),
        ),
      ),
    );
  }
}
