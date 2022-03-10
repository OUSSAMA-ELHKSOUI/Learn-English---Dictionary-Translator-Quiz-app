import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/quiz_match.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/quiz_test.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/quiz_write.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/word_in_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Quiz extends StatefulWidget {
  final Function toDictionary;
  final Function toTranslator;
  Quiz({this.toDictionary, this.toTranslator});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String textS(String text) {
    List<String> words = text.split(' ');
    String textS = '';
    if (words.length < 3) {
      for (int i = 0; i < words.length; i++) {
        textS += '${words[i]} ';
      }
      return textS;
    }
    for (int i = 0; i < 3; i++) {
      textS += '${words[i]} ';
    }
    return '$textS...';
  }

  @override
  Widget build(BuildContext context) {
    //bool a = true;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGreyBackGround,
        appBar: AppBar(
          backgroundColor: kBlue,
          title: Text(
            'Quiz',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontFamily: 'Carme'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Bares(Colors.white),
            )
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: FontAwesomeIcons.plus,
          activeIcon: FontAwesomeIcons.times,
          curve: Curves.bounceIn,
          //overlayColor: Colors.black,
          overlayOpacity: 0.5,
          //onOpen: () => a = false,
          //onClose: () => a = true,
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: kButtonColor,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.book, color: Colors.white, size: 14),
              backgroundColor: kBlue,
              label: 'Translator',
              labelStyle: TextStyle(fontSize: 14, fontFamily: "Carme"),
              onTap: widget.toTranslator,
            ),
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.book, color: Colors.white, size: 14),
              backgroundColor: kBlue,
              label: 'Dictionary',
              labelStyle: TextStyle(fontSize: 14, fontFamily: "Carme"),
              onTap: widget.toDictionary,
            ),
          ],
        ),
        body: Stack(
          children: [
            Provider.of<ValueManager>(context, listen: false)
                        .dictionaryTranslatorDataList
                        .length !=
                    0
                ? Consumer<ValueManager>(
                    builder: (context, data, child) {
                      Future.delayed(Duration.zero, () async {
                        data.refrich();
                      });
                      //data.getTasks();
                      return ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: 100,
                          top: MediaQuery.of(context).size.height / 3.4 + 54,
                          left: 20,
                          right: 20,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'words'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Carme",
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 3)
                              ],
                            );
                          }
                          return WordInQuiz(
                            word: textS(data
                                .dictionaryTranslatorDataList[
                                    data.dictionaryTranslatorDataList.length -
                                        index]
                                .word),
                            fromWhere: data
                                .dictionaryTranslatorDataList[
                                    data.dictionaryTranslatorDataList.length -
                                        index]
                                .fromWhere,
                            isChecked: data
                                .dictionaryTranslatorDataList[
                                    data.dictionaryTranslatorDataList.length -
                                        index]
                                .isChecked,
                            changeTriggerCheckbox: () {
                              data.changeIsCheckedInDictionaryTranslatorData(
                                  data.dictionaryTranslatorDataList[
                                      data.dictionaryTranslatorDataList.length -
                                          index]);
                              if (data
                                  .dictionaryTranslatorDataList[
                                      data.dictionaryTranslatorDataList.length -
                                          index]
                                  .isChecked) {
                                data.addToCheckedInDictionaryTranslatorDataListChecked(
                                    data.dictionaryTranslatorDataList[data
                                            .dictionaryTranslatorDataList
                                            .length -
                                        index]);
                              } else {
                                if (data.dictionaryTranslatorDataListChecked
                                    .contains(data.dictionaryTranslatorDataList[
                                        data.dictionaryTranslatorDataList
                                                .length -
                                            index])) {
                                  data.removeFromCheckedInDictionaryTranslatorDataListChecked(
                                      data.dictionaryTranslatorDataList[data
                                              .dictionaryTranslatorDataList
                                              .length -
                                          index]);
                                }
                              }
                              if (data.dictionaryTranslatorDataListChecked
                                      .length ==
                                  0) {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeAllWordChecked(true);
                              }
                            },
                          );
                        },
                        itemCount: data.dictionaryTranslatorDataList.length + 1,
                      );
                    },
                  )
                : Container(
                    padding: EdgeInsets.only(
                        top: 2.3 * MediaQuery.of(context).size.height / 5.5,
                        left: 23,
                        right: 23),
                    child: Text(
                      'Tap the + button to add some words from the dictionary or translator to do a quiz offline',
                      style: TextStyle(
                          color: kGreyComment,
                          fontFamily: 'Carme',
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
            Provider.of<ValueManager>(context, listen: false)
                        .dictionaryTranslatorDataList
                        .length !=
                    0
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 3.4,
                        width: double.infinity,
                        color: kGreyBackGround,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeAllWordChecked(true);
                            },
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kBorderCard
                                          : kGreyTexts,
                                      width: 1.5),
                                  top: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kBorderCard
                                          : kGreyTexts,
                                      width: 1.5),
                                  left: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kBorderCard
                                          : kGreyTexts,
                                      width: 1.5),
                                  right: BorderSide(
                                      color: kBorderCard, width: 1.5),
                                ),
                              ),
                              child: Text(
                                'All Words',
                                style: TextStyle(
                                    color: Provider.of<ValueManager>(context,
                                                listen: false)
                                            .allWordChecked
                                        ? kBorderCard
                                        : kGreyTexts,
                                    fontFamily: 'Carme',
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Provider.of<ValueManager>(context,
                                          listen: false)
                                      .dictionaryTranslatorDataListChecked
                                      .length !=
                                  0) {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeAllWordChecked(false);
                              }
                            },
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kGreyTexts
                                          : kBorderCard,
                                      width: 1.5),
                                  top: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kGreyTexts
                                          : kBorderCard,
                                      width: 1.5),
                                  right: BorderSide(
                                      color: Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .allWordChecked
                                          ? kGreyTexts
                                          : kBorderCard,
                                      width: 1.5),
                                ),
                              ),
                              child: Text(
                                '${Provider.of<ValueManager>(context).dictionaryTranslatorDataListChecked.length} word(s)',
                                style: TextStyle(
                                    color: Provider.of<ValueManager>(context,
                                                listen: false)
                                            .allWordChecked
                                        ? kGreyTexts
                                        : kBorderCard,
                                    fontFamily: 'Carme',
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Consumer<ValueManager>(
                    builder: (context, data, child) {
                      Future.delayed(Duration.zero, () async {
                        data.refrich();
                      });
                      //data.getTasks();
                      return Container(
                        width: double.infinity,
                      );
                    },
                  ),
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 5.5,
              width: double.infinity,
              color: Colors.white,
              child: Text(
                '${Provider.of<ValueManager>(context).dictionaryTranslatorDataList.length} word(s)',
                style: TextStyle(
                    color: kGreyTexts,
                    fontSize: 18,
                    fontFamily: 'Carme',
                    fontWeight: FontWeight.w900),
              ),
            ),
            Positioned(
              height: 2 * MediaQuery.of(context).size.height / 5.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardApp(
                      function: () {
                        if (Provider.of<ValueManager>(context, listen: false)
                                .dictionaryTranslatorDataList
                                .length !=
                            0)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizMatch(),
                            ),
                          );
                      },
                      name: "MATCH",
                      icon: FontAwesomeIcons.table,
                    ),
                    SizedBox(width: 12.5),
                    CardApp(
                      function: () {
                        if (Provider.of<ValueManager>(context, listen: false)
                                .dictionaryTranslatorDataList
                                .length !=
                            0)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizTest(),
                            ),
                          );
                      },
                      name: "TEST",
                      icon: FontAwesomeIcons.fileAlt,
                    ),
                    SizedBox(width: 12.5),
                    CardApp(
                      function: () {
                        if (Provider.of<ValueManager>(context, listen: false)
                                .dictionaryTranslatorDataList
                                .length !=
                            0)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizWrite(),
                            ),
                          );
                      },
                      name: "WRITE",
                      icon: FontAwesomeIcons.pencilAlt,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// todo check if the list in valuemanatger tatApdayta
// todo print dakchi li jayb sql to look
