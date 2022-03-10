import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DefAndExa extends StatelessWidget {
  Future getDictionaryData(String word) async {
    String url =
        'url that fetch definitions, examples and synonyms of an English word';

    try {
      http.Response response = await http.get(url);
      //print(response.statusCode.toString() + 'rrrrr');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode ~/ 100 == 5) {
        return {
          'word': '500',
          'definition': ['500'],
          'noun or verb': ['500']
        };
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<bool> message(BuildContext context, String msg) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                msg,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Carme",
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    'ok',
                    style: TextStyle(
                      color: kButtonColor,
                      fontSize: 20,
                      fontFamily: "Carme",
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  final String definition;
  final dynamic definitionList;
  final String example;
  final int numbDefinition;
  final String nounOrVerb;

  DefAndExa({
    this.definition,
    this.example,
    this.numbDefinition,
    this.nounOrVerb,
    this.definitionList,
  });

  @override
  Widget build(BuildContext context) {
    bool isAdjective = false;
    bool isNoun = false;
    bool isVerb = false;
    bool nanOfTheme = false;

    if (nounOrVerb == "adjective") {
      isAdjective = true;
    } else if (nounOrVerb == "noun") {
      isNoun = true;
    } else if (nounOrVerb == "verb") {
      isVerb = true;
    } else {
      nanOfTheme = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  nanOfTheme ? nounOrVerb : "adjective",
                  style: TextStyle(
                    color: nanOfTheme || isAdjective ? Colors.white : kBlue,
                    fontSize: 14,
                    fontFamily: "Carme",
                    //fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: nanOfTheme || isAdjective ? kBlue : Colors.white,
                border: Border(
                  top: BorderSide(width: 1.0, color: kBlue),
                  left: BorderSide(width: 1.0, color: kBlue),
                  bottom: BorderSide(width: 1.0, color: kBlue),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "noun",
                  style: TextStyle(
                    color: isNoun ? Colors.white : kBlue,
                    fontSize: 14,
                    fontFamily: "Carme",
                    //fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: isNoun ? kBlue : Colors.white,
                border: Border(
                  top: BorderSide(width: 1.0, color: kBlue),
                  left: BorderSide(width: 1.0, color: kBlue),
                  bottom: BorderSide(width: 1.0, color: kBlue),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "verb",
                  style: TextStyle(
                    color: isVerb ? Colors.white : kBlue,
                    fontSize: 14,
                    fontFamily: "Carme",
                    //fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: isVerb ? kBlue : Colors.white,
                  border: Border.all(
                    color: kBlue,
                    width: 1,
                  )),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          'definition'.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "Carme",
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 3),
        Provider.of<ValueManager>(context, listen: false).definitions[0] ==
                "definitionWithWordToSearch"
            ? definitionList[1] == ""
                ? RichText(
                    text: TextSpan(
                      text: '$numbDefinition. ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kBlueSearchWord),
                      children: [
                        TextSpan(
                            text: definitionList[0]
                                .replaceAll('&#39;', "'")
                                .trimRight()
                                .trimLeft(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Carme",
                            )),
                      ],
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      text: '$numbDefinition. ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kBlueSearchWord),
                      children: [
                        TextSpan(
                          text: '${definitionList[0]} '
                              .trimLeft()
                              .replaceAll('&#39;', "'"),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Carme",
                          ),
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD2();
                                var data = await getDictionaryData(
                                    definitionList[1]
                                        .replaceAll('&#39;', "'")
                                        .trimRight()
                                        .trimLeft());
                                if (data['word'] != null) {
                                  if (data != {}) {
                                    try {
                                      if (data['word'] != '500' &&
                                          data['definition'] != ['500'] &&
                                          data['noun or verb'] != ['500']) {
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeWord(data['word']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changePronunciationWordUk(
                                                'UK ${data['pronunciation']['uk'][1]}');
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changePronunciationWordUs(
                                                'US ${data['pronunciation']['us'][1]}');
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changePronunciationSoundUk(
                                                'UK ${data['pronunciation']['uk'][0]}');
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changePronunciationSoundUs(
                                                'UK ${data['pronunciation']['us'][0]}');
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeDefinitions(
                                                data['definition']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeExamples(data['example']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeSynonyms(data['synonym']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeMoreExamples(
                                                data['more example']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeMoreDefinitions(
                                                data['more definition']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeNounOrVerb(
                                                data['noun or verb']);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeAfterPressingButton(true);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .getWords();
                                      } else {
                                        message(context,
                                            'Sorry...Internet Server Error');
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeToDictionary(true);
                                      }
                                      Provider.of<ValueManager>(context,
                                              listen: false)
                                          .changeShowModalHUD2();
                                    } catch (e) {
                                      // Provider.of<ValueManager>(context,
                                      //         listen: false)
                                      //     .changeShowModalHUD2();
                                      // todo problem here when you keep spinner turn
                                      // Provider.of<ValueManager>(context,
                                      //         listen: false)
                                      //     .changeToDictionary(true);
                                      // print("eeeerrr" + e.toString());
                                      // message(context,
                                      //     'It looks like you\'ve lost your Internet connection');
                                    }
                                  }
                                } else {
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeShowModalHUD2();
                                  message(context,
                                      'It looks like you\'ve lost your Internet connection');
                                }
                              },
                            text: definitionList[1]
                                .replaceAll('&#39;', "'")
                                .trimRight()
                                .trimLeft(),
                            style: TextStyle(
                              color: kBlueSearchWord,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Carme",
                            )),
                      ],
                    ),
                  )
            : RichText(
                text: TextSpan(
                  text: '$numbDefinition. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kBlueSearchWord),
                  children: [
                    TextSpan(
                        text: definition.trimRight().trimLeft(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Carme",
                        )),
                  ],
                ),
              ),
        example != ''
            ? SizedBox(height: 15)
            : Container(width: double.infinity),
        example != ''
            ? Text(
                'example'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: "Carme",
                  fontWeight: FontWeight.w900,
                ),
              )
            : Container(width: double.infinity),
        example != '' ? SizedBox(height: 3) : Container(width: double.infinity),
        example != ''
            ? RichText(
                text: TextSpan(
                  text: '$numbDefinition. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kBlueSearchWord),
                  children: [
                    TextSpan(
                        text: example.trimRight().trimLeft(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Carme",
                        )),
                  ],
                ),
              )
            : Container(width: double.infinity),
      ],
    );
  }
}
