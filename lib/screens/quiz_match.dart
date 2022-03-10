import 'dart:math';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import '../dictionary_translator_data.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/game_over.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/done_remain_text.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/match_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizMatch extends StatefulWidget {
  //final Random random = Random();
  @override
  _QuizMatchState createState() => _QuizMatchState();
}

class _QuizMatchState extends State<QuizMatch> {
  Random random;
  List list;

  DictionaryTranslatorData randomDictionaryTranslatorData;
  DictionaryTranslatorData randomDictionaryTranslatorData1;
  DictionaryTranslatorData randomDictionaryTranslatorData2;
  DictionaryTranslatorData randomDictionaryTranslatorData3;
  int randomDif;
  int randomDif1;
  int randomDif2;
  int randomDif3;
  List texts;
  String text11;
  String text12;
  String text21;
  String text22;
  String text31;
  String text32;
  String text41;
  String text42;
  int numberCardLeaft = 1;
  int numberCardLeaft2 = 2;
  int numberCardLeaft3 = 3;
  int numberCardLeaft4 = 4;

  bool noOnPress = true;
  bool noOnPress2 = true;
  bool noOnPress3 = true;
  bool noOnPress4 = true;
  bool noOnPress5 = true;
  bool noOnPress6 = true;
  bool noOnPress7 = true;
  bool noOnPress8 = true;

  int numberOfCard = 0;

  bool isCheckedCard = false;

  bool isCheckedCard1 = false;
  bool isCheckedCard2 = false;
  bool isCheckedCard3 = false;
  bool isCheckedCard4 = false;
  bool isCheckedCard5 = false;
  bool isCheckedCard6 = false;
  bool isCheckedCard7 = false;
  bool isCheckedCard8 = false;
  bool matchFalse1 = false;
  bool matchFalse2 = false;
  bool matchFalse3 = false;
  bool matchFalse4 = false;
  bool matchFalse5 = false;
  bool matchFalse6 = false;
  bool matchFalse7 = false;
  bool matchFalse8 = false;

  List<int> randomIntegersList;

  int done = 0;

  int firstTry;
  bool firstTryCheck = true;
  int listLength;

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
    listLength = list.length;

    if (list.length == 1) {
      randomDif = random.nextInt(list[0].definitionOrTranslation.length);
      texts = [list[0].word, list[0].definitionOrTranslation[randomDif]];
      text11 = texts[random.nextInt(texts.length)];
      texts.remove(text11);
      text12 = texts[random.nextInt(texts.length)];
    } else if (list.length == 2) {
      randomDif = random.nextInt(list[0].definitionOrTranslation.length);
      randomDif1 = random.nextInt(list[1].definitionOrTranslation.length);
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1]
      ];
      text11 = texts[random.nextInt(texts.length)];
      texts.remove(text11);
      text12 = texts[random.nextInt(texts.length)];
      texts.remove(text12);
      text21 = texts[random.nextInt(texts.length)];
      texts.remove(text21);
      text22 = texts[random.nextInt(texts.length)];
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1]
      ];
    } else if (list.length == 3) {
      randomDif = random.nextInt(list[0].definitionOrTranslation.length);
      randomDif1 = random.nextInt(list[1].definitionOrTranslation.length);
      randomDif2 = random.nextInt(list[2].definitionOrTranslation.length);
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1],
        list[2].word + '\n' + list[2].fromWhere,
        list[2].definitionOrTranslation[randomDif2]
      ];
      text11 = texts[random.nextInt(texts.length)];
      texts.remove(text11);
      text12 = texts[random.nextInt(texts.length)];
      texts.remove(text12);
      text21 = texts[random.nextInt(texts.length)];
      texts.remove(text21);
      text22 = texts[random.nextInt(texts.length)];
      texts.remove(text22);
      text31 = texts[random.nextInt(texts.length)];
      texts.remove(text31);
      text32 = texts[random.nextInt(texts.length)];
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1],
        list[2].word + '\n' + list[2].fromWhere,
        list[2].definitionOrTranslation[randomDif2]
      ];
    } else if (list.length == 4) {
      randomDif = random.nextInt(list[0].definitionOrTranslation.length);
      randomDif1 = random.nextInt(list[1].definitionOrTranslation.length);
      randomDif2 = random.nextInt(list[2].definitionOrTranslation.length);
      randomDif3 = random.nextInt(list[3].definitionOrTranslation.length);
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1],
        list[2].word + '\n' + list[2].fromWhere,
        list[2].definitionOrTranslation[randomDif2],
        list[3].word + '\n' + list[3].fromWhere,
        list[3].definitionOrTranslation[randomDif3],
      ];
      text11 = texts[random.nextInt(texts.length)];
      texts.remove(text11);
      text12 = texts[random.nextInt(texts.length)];
      texts.remove(text12);
      text21 = texts[random.nextInt(texts.length)];
      texts.remove(text21);
      text22 = texts[random.nextInt(texts.length)];
      texts.remove(text22);
      text31 = texts[random.nextInt(texts.length)];
      texts.remove(text31);
      text32 = texts[random.nextInt(texts.length)];
      texts.remove(text32);
      text41 = texts[random.nextInt(texts.length)];
      texts.remove(text41);
      text42 = texts[random.nextInt(texts.length)];
      texts = [
        list[0].word + '\n' + list[0].fromWhere,
        list[0].definitionOrTranslation[randomDif],
        list[1].word + '\n' + list[1].fromWhere,
        list[1].definitionOrTranslation[randomDif1],
        list[2].word + '\n' + list[2].fromWhere,
        list[2].definitionOrTranslation[randomDif2],
        list[3].word + '\n' + list[3].fromWhere,
        list[3].definitionOrTranslation[randomDif3],
      ];
    } else {
      firstTry = 4;
      listLength = 4;
      List<int> integersList = [];
      int a = 0;
      for (int i = 0; i < list.length; i++) {
        integersList.add(a++);
      }

      randomIntegersList = [];
      for (int i = 0; i < 4; i++) {
        int number = random.nextInt(integersList.length);
        randomIntegersList.add(integersList[number]);
        integersList.remove(integersList[number]);
      }

      randomDif = random
          .nextInt(list[randomIntegersList[0]].definitionOrTranslation.length);
      randomDif1 = random
          .nextInt(list[randomIntegersList[1]].definitionOrTranslation.length);
      randomDif2 = random
          .nextInt(list[randomIntegersList[2]].definitionOrTranslation.length);
      randomDif3 = random
          .nextInt(list[randomIntegersList[3]].definitionOrTranslation.length);
      texts = [
        list[randomIntegersList[0]].word +
            '\n' +
            list[randomIntegersList[0]].fromWhere,
        list[randomIntegersList[0]].definitionOrTranslation[randomDif],
        list[randomIntegersList[1]].word +
            '\n' +
            list[randomIntegersList[1]].fromWhere,
        list[randomIntegersList[1]].definitionOrTranslation[randomDif1],
        list[randomIntegersList[2]].word +
            '\n' +
            list[randomIntegersList[2]].fromWhere,
        list[randomIntegersList[2]].definitionOrTranslation[randomDif2],
        list[randomIntegersList[3]].word +
            '\n' +
            list[randomIntegersList[3]].fromWhere,
        list[randomIntegersList[3]].definitionOrTranslation[randomDif3],
      ];
      text11 = texts[random.nextInt(texts.length)];
      texts.remove(text11);
      text12 = texts[random.nextInt(texts.length)];
      texts.remove(text12);
      text21 = texts[random.nextInt(texts.length)];
      texts.remove(text21);
      text22 = texts[random.nextInt(texts.length)];
      texts.remove(text22);
      text31 = texts[random.nextInt(texts.length)];
      texts.remove(text31);
      text32 = texts[random.nextInt(texts.length)];
      texts.remove(text32);
      text41 = texts[random.nextInt(texts.length)];
      texts.remove(text41);
      text42 = texts[random.nextInt(texts.length)];
      texts = [
        list[randomIntegersList[0]].word +
            '\n' +
            list[randomIntegersList[0]].fromWhere,
        list[randomIntegersList[0]].definitionOrTranslation[randomDif],
        list[randomIntegersList[1]].word +
            '\n' +
            list[randomIntegersList[1]].fromWhere,
        list[randomIntegersList[1]].definitionOrTranslation[randomDif1],
        list[randomIntegersList[2]].word +
            '\n' +
            list[randomIntegersList[2]].fromWhere,
        list[randomIntegersList[2]].definitionOrTranslation[randomDif2],
        list[randomIntegersList[3]].word +
            '\n' +
            list[randomIntegersList[3]].fromWhere,
        list[randomIntegersList[3]].definitionOrTranslation[randomDif3],
      ];
    }
  }

  int foundIndex(int random) {
    switch (random) {
      case 0:
        return 0;
      case 1:
        return 0;
      case 2:
        return 1;
      case 3:
        return 1;
      case 4:
        return 2;
      case 5:
        return 2;
      case 6:
        return 3;
      default:
        return 3;
    }
  }

  void changeIsChecked(int numberOfCard, bool value) {
    switch (numberOfCard) {
      case 1:
        isCheckedCard1 = value;
        break;
      case 2:
        isCheckedCard2 = value;
        break;
      case 3:
        isCheckedCard3 = value;
        break;
      case 4:
        isCheckedCard4 = value;
        break;
      case 5:
        isCheckedCard5 = value;
        break;
      case 6:
        isCheckedCard6 = value;
        break;
      case 7:
        isCheckedCard7 = value;
        break;
      case 8:
        isCheckedCard8 = value;
        break;
    }
  }

  void changeMatchFalse(int numberOfCard, bool value) {
    switch (numberOfCard) {
      case 1:
        matchFalse1 = value;
        break;
      case 2:
        matchFalse2 = value;
        break;
      case 3:
        matchFalse3 = value;
        break;
      case 4:
        matchFalse4 = value;
        break;
      case 5:
        matchFalse5 = value;
        break;
      case 6:
        matchFalse6 = value;
        break;
      case 7:
        matchFalse7 = value;
        break;
      case 8:
        matchFalse8 = value;
        break;
    }
  }

  String text(int numberOfCard) {
    switch (numberOfCard) {
      case 1:
        return text11;
      case 2:
        return text12;
      case 3:
        return text21;
      case 4:
        return text22;
      case 5:
        return text31;
      case 6:
        return text32;
      case 7:
        return text41;
      default:
        return text42;
    }
  }

  void noPress(int numberOfCard) {
    switch (numberOfCard) {
      case 1:
        noOnPress = false;
        break;
      case 2:
        noOnPress2 = false;
        break;
      case 3:
        noOnPress3 = false;
        break;
      case 4:
        noOnPress4 = false;
        break;
      case 5:
        noOnPress5 = false;
        break;
      case 6:
        noOnPress6 = false;
        break;
      case 7:
        noOnPress7 = false;
        break;
      default:
        noOnPress8 = false;
        break;
    }
  }

  void setNoOnPresses(int numberOfCard, bool value) {
    switch (numberOfCard) {
      case 1:
        noOnPress = value;
        break;
      case 2:
        noOnPress2 = value;
        break;
      case 3:
        noOnPress3 = value;
        break;
      case 4:
        noOnPress4 = value;
        break;
      case 5:
        noOnPress5 = value;
        break;
      case 6:
        noOnPress6 = value;
        break;
      case 7:
        noOnPress7 = value;
        break;
      default:
        noOnPress8 = value;
        break;
    }
  }

  int randomDefinition(int index) {
    switch (index) {
      case 0:
        return randomDif;
      case 1:
        return randomDif1;
      case 2:
        return randomDif2;
      default:
        return randomDif3;
    }
  }

  int cardLeft(int num) {
    switch (num) {
      case 1:
        return numberCardLeaft;
      case 2:
        return numberCardLeaft2;
      case 3:
        return numberCardLeaft3;
      default:
        return numberCardLeaft4;
    }
  }

  int cardLeftM1(int num) {
    switch (num) {
      case 1:
        return numberCardLeaft--;
      case 2:
        return numberCardLeaft2--;
      case 3:
        return numberCardLeaft3--;
      default:
        return numberCardLeaft4--;
    }
  }

  void onPressFunction(bool noOnPress3, int numCard, String textN,
      int numCardLeft, List<DictionaryTranslatorData> li) {
    if (noOnPress3) {
      if (numberOfCard == 0) numberOfCard = numCard;
      int indexOfT = texts.indexOf(textN);
      if (!isCheckedCard) {
        setState(() {
          changeIsChecked(numCard, true);
        });
        isCheckedCard = true;
      } else {
        if ((li[foundIndex(indexOfT)].word +
                        '\n' +
                        li[foundIndex(indexOfT)].fromWhere ==
                    textN &&
                li[foundIndex(indexOfT)].definitionOrTranslation[
                        randomDefinition(foundIndex(indexOfT))] ==
                    text(numberOfCard)) ||
            (li[foundIndex(indexOfT)].word +
                        '\n' +
                        li[foundIndex(indexOfT)].fromWhere ==
                    text(numberOfCard) &&
                li[foundIndex(indexOfT)].definitionOrTranslation[
                        randomDefinition(foundIndex(indexOfT))] ==
                    textN)) {
          cardLeftM1(numCardLeft);
          setNoOnPresses(numCard, false);
          noPress(numberOfCard);
          setState(() {
            changeIsChecked(numCard, true);
            Future.delayed(Duration(milliseconds: 200), () async {
              changeIsChecked(numCard, false);
              changeIsChecked(numberOfCard, false);
              changeMatchFalse(numCard, true);
              changeMatchFalse(numberOfCard, true);
              numberOfCard = 0;
              done++;
              firstTryCheck = true;
            });
          });
        } else {
          setState(() {
            changeIsChecked(numCard, true);
            changeMatchFalse(numCard, true);
            changeMatchFalse(numberOfCard, true);
            Future.delayed(Duration(milliseconds: 200), () async {
              changeIsChecked(numCard, false);
              changeIsChecked(numberOfCard, false);
              changeMatchFalse(numCard, false);
              changeMatchFalse(numberOfCard, false);
              numberOfCard = 0;
              if (firstTryCheck) {
                firstTryCheck = false;
                firstTry--;
              }
            });
          });
        }
        isCheckedCard = false;
      }
      if (cardLeft(numCardLeft) == 0) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameOver(
              function: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizMatch()));
              },
              numberWord: listLength,
              firstTry: firstTry,
            ),
          ),
        );
      }
    }
  }

  void onPressFunctionAllWords(bool noOnPress3, int numCard, String textN,
      int numCardLeft, List<DictionaryTranslatorData> li) {
    if (noOnPress3) {
      if (numberOfCard == 0) numberOfCard = numCard;
      int indexOfT = texts.indexOf(textN);
      if (!isCheckedCard) {
        setState(() {
          changeIsChecked(numCard, true);
        });
        isCheckedCard = true;
      } else {
        if ((li[randomIntegersList[foundIndex(indexOfT)]].word +
                        '\n' +
                        li[randomIntegersList[foundIndex(indexOfT)]]
                            .fromWhere ==
                    textN &&
                li[randomIntegersList[foundIndex(indexOfT)]]
                            .definitionOrTranslation[
                        randomDefinition(foundIndex(indexOfT))] ==
                    text(numberOfCard)) ||
            (li[randomIntegersList[foundIndex(indexOfT)]].word +
                        '\n' +
                        li[randomIntegersList[foundIndex(indexOfT)]]
                            .fromWhere ==
                    text(numberOfCard) &&
                li[randomIntegersList[foundIndex(indexOfT)]]
                            .definitionOrTranslation[
                        randomDefinition(foundIndex(indexOfT))] ==
                    textN)) {
          cardLeftM1(numCardLeft);
          setNoOnPresses(numCard, false);
          noPress(numberOfCard);
          setState(() {
            changeIsChecked(numCard, true);
            Future.delayed(Duration(milliseconds: 200), () async {
              changeIsChecked(numCard, false);
              changeIsChecked(numberOfCard, false);
              changeMatchFalse(numCard, true);
              changeMatchFalse(numberOfCard, true);
              numberOfCard = 0;
              done++;
              firstTryCheck = true;
            });
          });
        } else {
          setState(() {
            changeIsChecked(numCard, true);
            changeMatchFalse(numCard, true);
            changeMatchFalse(numberOfCard, true);
            Future.delayed(Duration(milliseconds: 200), () async {
              changeIsChecked(numCard, false);
              changeIsChecked(numberOfCard, false);
              changeMatchFalse(numCard, false);
              changeMatchFalse(numberOfCard, false);
              numberOfCard = 0;
              if (firstTryCheck) {
                firstTryCheck = false;
                firstTry--;
              }
            });
          });
        }
        isCheckedCard = false;
      }
      if (cardLeft(numCardLeft) == 0) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameOver(
              function: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizMatch()));
              },
              numberWord: listLength,
              firstTry: firstTry,
            ),
          ),
        );
      }
    }
  }

  Widget numberOfMatchCard(List list, BuildContext context) {
    if (list.length == 1) {
      return Consumer<ValueManager>(
        builder: (context, data, child) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: Provider.of<ValueManager>(context,
                                    listen: false)
                                .allWordChecked
                            ? () {
                                if (noOnPress) {
                                  if (!isCheckedCard2) {
                                    setState(() {
                                      isCheckedCard1 = true;
                                    });
                                  } else {
                                    if ((data.dictionaryTranslatorDataList[0]
                                                    .word ==
                                                text11 &&
                                            data.dictionaryTranslatorDataList[0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text12) ||
                                        (data.dictionaryTranslatorDataList[0]
                                                    .word ==
                                                text12 &&
                                            data.dictionaryTranslatorDataList[0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text11)) {
                                      numberCardLeaft--;
                                      noOnPress = false;
                                      setState(() {
                                        isCheckedCard1 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = true;
                                          matchFalse2 = true;
                                          done++;
                                          firstTryCheck = true;
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        isCheckedCard1 = true;
                                        matchFalse1 = true;
                                        matchFalse2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = false;
                                          matchFalse2 = false;
                                          if (firstTryCheck) {
                                            firstTryCheck = false;
                                            firstTry--;
                                          }
                                        });
                                      });
                                    }
                                  }
                                  if (numberCardLeaft == 0) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameOver(
                                          function: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizMatch()));
                                          },
                                          numberWord: listLength,
                                          firstTry: firstTry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            : () {
                                if (noOnPress) {
                                  if (!isCheckedCard2) {
                                    setState(() {
                                      isCheckedCard1 = true;
                                    });
                                  } else {
                                    if ((data
                                                    .dictionaryTranslatorDataListChecked[
                                                        0]
                                                    .word ==
                                                text11 &&
                                            data
                                                        .dictionaryTranslatorDataListChecked[
                                                            0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text12) ||
                                        (data
                                                    .dictionaryTranslatorDataListChecked[
                                                        0]
                                                    .word ==
                                                text12 &&
                                            data
                                                        .dictionaryTranslatorDataListChecked[
                                                            0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text11)) {
                                      numberCardLeaft--;
                                      noOnPress = false;
                                      setState(() {
                                        isCheckedCard1 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = true;
                                          matchFalse2 = true;
                                          done++;
                                          firstTryCheck = true;
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        isCheckedCard1 = true;
                                        matchFalse1 = true;
                                        matchFalse2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = false;
                                          matchFalse2 = false;
                                          if (firstTryCheck) {
                                            firstTryCheck = false;
                                            firstTry--;
                                          }
                                        });
                                      });
                                    }
                                  }
                                  if (numberCardLeaft == 0) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameOver(
                                          function: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizMatch()));
                                          },
                                          numberWord: listLength,
                                          firstTry: firstTry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                        isCheckedCard:
                            isCheckedCard1, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse1, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text11),
                    MatchCard(
                        function: Provider.of<ValueManager>(context,
                                    listen: false)
                                .allWordChecked
                            ? () {
                                if (noOnPress) {
                                  if (!isCheckedCard1) {
                                    setState(() {
                                      isCheckedCard2 = true;
                                    });
                                  } else {
                                    if ((data.dictionaryTranslatorDataList[0]
                                                    .word ==
                                                text11 &&
                                            data.dictionaryTranslatorDataList[0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text12) ||
                                        (data.dictionaryTranslatorDataList[0]
                                                    .word ==
                                                text12 &&
                                            data.dictionaryTranslatorDataList[0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text11)) {
                                      numberCardLeaft--;
                                      noOnPress = false;
                                      setState(() {
                                        isCheckedCard2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = true;
                                          matchFalse2 = true;
                                          done++;
                                          firstTryCheck = true;
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        isCheckedCard2 = true;
                                        matchFalse1 = true;
                                        matchFalse2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = false;
                                          matchFalse2 = false;
                                          if (firstTryCheck) {
                                            firstTryCheck = false;
                                            firstTry--;
                                          }
                                        });
                                      });
                                    }
                                  }
                                  if (numberCardLeaft == 0) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameOver(
                                          function: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizMatch()));
                                          },
                                          numberWord: listLength,
                                          firstTry: firstTry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            : () {
                                if (noOnPress) {
                                  if (!isCheckedCard1) {
                                    setState(() {
                                      isCheckedCard2 = true;
                                    });
                                  } else {
                                    if ((data
                                                    .dictionaryTranslatorDataListChecked[
                                                        0]
                                                    .word ==
                                                text11 &&
                                            data
                                                        .dictionaryTranslatorDataListChecked[
                                                            0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text12) ||
                                        (data
                                                    .dictionaryTranslatorDataListChecked[
                                                        0]
                                                    .word ==
                                                text12 &&
                                            data
                                                        .dictionaryTranslatorDataListChecked[
                                                            0]
                                                        .definitionOrTranslation[
                                                    randomDif] ==
                                                text11)) {
                                      numberCardLeaft--;
                                      noOnPress = false;
                                      setState(() {
                                        isCheckedCard2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = true;
                                          matchFalse2 = true;
                                          done++;
                                          firstTryCheck = true;
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        isCheckedCard2 = true;
                                        matchFalse1 = true;
                                        matchFalse2 = true;
                                        Future.delayed(
                                            Duration(milliseconds: 200),
                                            () async {
                                          isCheckedCard1 = false;
                                          isCheckedCard2 = false;
                                          matchFalse1 = false;
                                          matchFalse2 = false;
                                          if (firstTryCheck) {
                                            firstTryCheck = false;
                                            firstTry--;
                                          }
                                        });
                                      });
                                    }
                                  }
                                  if (numberCardLeaft == 0) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameOver(
                                          function: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizMatch()));
                                          },
                                          numberWord: listLength,
                                          firstTry: firstTry,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                        colorBG: kBackGroundDicColor,
                        isCheckedCard:
                            isCheckedCard2, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse2, // provider get DictionaryTranslatorData get matchFalse
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text12)
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else if (list.length == 2) {
      return Consumer<ValueManager>(
        builder: (context, data, child) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress,
                            1,
                            text11,
                            2,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard1, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse1, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text11),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress2,
                            2,
                            text12,
                            2,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard2, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse2, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text12),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress3,
                            3,
                            text21,
                            2,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard3, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse3, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text21),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress4,
                            4,
                            text22,
                            2,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard4, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse4, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text22),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else if (list.length == 3) {
      return Consumer<ValueManager>(
        builder: (context, data, child) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress,
                            1,
                            text11,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard1, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse1, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text11),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress2,
                            2,
                            text12,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard2, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse2, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text12),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress3,
                            3,
                            text21,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard3, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse3, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text21),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress4,
                            4,
                            text22,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard4, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse4, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text22),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress5,
                            5,
                            text31,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard5, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse5, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text31),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress6,
                            6,
                            text32,
                            3,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard6, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse6, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text32),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else if (list.length == 4) {
      return Consumer<ValueManager>(
        builder: (context, data, child) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress,
                            1,
                            text11,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard1, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse1, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text11),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress2,
                            2,
                            text12,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard2, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse2, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text12),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress3,
                            3,
                            text21,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard3, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse3, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text21),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress4,
                            4,
                            text22,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard4, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse4, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text22),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress5,
                            5,
                            text31,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard5, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse5, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text31),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress6,
                            6,
                            text32,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard6, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse6, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text32),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress7,
                            7,
                            text41,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard7, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse7, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text41),
                    MatchCard(
                        function: () => onPressFunction(
                            noOnPress8,
                            8,
                            text42,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard8, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse8, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text42),
                    MatchCard(
                        function: () {},
                        isCheckedCard: false,
                        matchFalse: false,
                        colorBG: kBackGroundDicColor,
                        colorBorder: kBackGroundDicColor,
                        colorText: kBackGroundDicColor,
                        text: 'word'),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Consumer<ValueManager>(
        builder: (context, data, child) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress,
                            1,
                            text11,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard1, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse1, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text11),
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress2,
                            2,
                            text12,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard2, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse2, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text12),
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress3,
                            3,
                            text21,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard3, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse3, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text21),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress4,
                            4,
                            text22,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard4, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse4, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text22),
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress5,
                            5,
                            text31,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard5, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse5, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text31),
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress6,
                            6,
                            text32,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard6, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse6, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text32),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress7,
                            7,
                            text41,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard7, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse7, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text41),
                    MatchCard(
                        function: () => onPressFunctionAllWords(
                            noOnPress8,
                            8,
                            text42,
                            4,
                            data.allWordChecked
                                ? data.dictionaryTranslatorDataList
                                : data.dictionaryTranslatorDataListChecked),
                        isCheckedCard:
                            isCheckedCard8, // provider get DictionaryTranslatorData get isChecked
                        matchFalse:
                            matchFalse8, // provider get DictionaryTranslatorData get matchFalse
                        colorBG: kBackGroundDicColor,
                        colorBorder: kGreyTexts,
                        colorText: Colors.black,
                        text: text42),
                    MatchCard(
                        function: () {},
                        isCheckedCard: false,
                        matchFalse: false,
                        colorBG: kBackGroundDicColor,
                        colorBorder: kBackGroundDicColor,
                        colorText: kBackGroundDicColor,
                        text: 'word'),
                  ],
                ),
              ),
            ],
          );
        },
      );
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => pressBackButton(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackGroundDicColor,
          appBar: AppBar(
            backgroundColor: kBackGroundDicColor,
            elevation: 0,
            title: DoneRemainText(
              done: done,
              remain: listLength - done,
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
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 3, left: 3),
            child: numberOfMatchCard(list, context),
          ),
        ),
      ),
    );
  }
}
