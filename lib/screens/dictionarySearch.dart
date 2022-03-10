import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DictionarySearch extends StatelessWidget {
  Future getDictionaryData(String word) async {
    String url =
        'url that fetch definitions, examples and synonyms of an English word';

    try {
      http.Response response = await http.get(url);
      //print(response.statusCode.toString() + 'rrrrr');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall:
            Provider.of<ValueManager>(context, listen: false).showModalHUD,
        child: Scaffold(
          backgroundColor: kBackGroundDicColor,
          appBar: AppBar(
            backgroundColor: kBackGroundDicColor,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Bares(kBlue),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                ),
                Text(
                  'Dictionary',
                  style: TextStyle(
                    color: kBlue,
                    fontSize: 40,
                    fontFamily: "Carme",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) async {
                    Provider.of<ValueManager>(context, listen: false)
                        .changeShowModalHUD();
                    if (Provider.of<ValueManager>(context, listen: false)
                            .wordSearchDictionary !=
                        '') {
                      if (!Provider.of<ValueManager>(context, listen: false)
                              .wordSearchDictionary
                              .contains('&') &&
                          !Provider.of<ValueManager>(context, listen: false)
                              .wordSearchDictionary
                              .contains('*') &&
                          !Provider.of<ValueManager>(context, listen: false)
                              .wordSearchDictionary
                              .contains('?') &&
                          !Provider.of<ValueManager>(context, listen: false)
                              .wordSearchDictionary
                              .contains('/')) {
                        var data = await getDictionaryData(
                            Provider.of<ValueManager>(context, listen: false)
                                .wordSearchDictionary);
                        if (data['word'] != null) {
                          if (data != {}) {
                            if (data['word'] != "word not find") {
                              try {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeSearchForEmpty(false);
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD();
                                if (data['word'] != '500' &&
                                    data['definition'][0] != '500' &&
                                    data['noun or verb'][0] != '500') {
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
                                          data['pronunciation']['uk'][0]);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changePronunciationSoundUs(
                                          data['pronunciation']['us'][0]);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeDefinitions(data['definition']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeExamples(data['example']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeSynonyms(data['synonym']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeMoreExamples(data['more example']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeMoreDefinitions(
                                          data['more definition']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeNounOrVerb(data['noun or verb']);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeAfterPressingButton(true);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeToDictionary(false);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .getWords();
                                } else {
                                  message(
                                      context, 'Sorry...Internet Server Error');
                                }
                              } catch (e) {
                                message(context,
                                    'It looks like you\'ve lost your Internet connection');
                              }
                            } else {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowModalHUD();
                              message(context,
                                  'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                            }
                          } else {
                            Provider.of<ValueManager>(context, listen: false)
                                .changeShowModalHUD();
                            message(context,
                                'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                          }
                        } else {
                          Provider.of<ValueManager>(context, listen: false)
                              .changeShowModalHUD();
                          message(context,
                              'It looks like you\'ve lost your Internet connection');
                        }
                      } else {
                        Provider.of<ValueManager>(context, listen: false)
                            .changeShowModalHUD();
                        message(context,
                            'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                      }
                    } else {
                      Provider.of<ValueManager>(context, listen: false)
                          .changeSearchForEmpty(true);
                      Provider.of<ValueManager>(context, listen: false)
                          .changeShowModalHUD();
                    }
                  },
                  onChanged: (value) {
                    Provider.of<ValueManager>(context, listen: false)
                        .changeSearchForEmpty(false);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeWordSearchDictionary(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                        onTap: () async {
                          Provider.of<ValueManager>(context, listen: false)
                              .changeShowModalHUD();
                          FocusScope.of(context).unfocus();
                          if (Provider.of<ValueManager>(context, listen: false)
                                  .wordSearchDictionary !=
                              '') {
                            if (!Provider.of<ValueManager>(context,
                                        listen: false)
                                    .wordSearchDictionary
                                    .contains('&') &&
                                !Provider.of<ValueManager>(context,
                                        listen: false)
                                    .wordSearchDictionary
                                    .contains('*') &&
                                !Provider.of<ValueManager>(context,
                                        listen: false)
                                    .wordSearchDictionary
                                    .contains('?') &&
                                !Provider.of<ValueManager>(context,
                                        listen: false)
                                    .wordSearchDictionary
                                    .contains('/')) {
                              var data = await getDictionaryData(
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .wordSearchDictionary);
                              if (data['word'] != null) {
                                if (data != {}) {
                                  if (data['word'] != "word not find") {
                                    try {
                                      Provider.of<ValueManager>(context,
                                              listen: false)
                                          .changeSearchForEmpty(false);
                                      Provider.of<ValueManager>(context,
                                              listen: false)
                                          .changeShowModalHUD();
                                      if (data['word'] != '500' &&
                                          data['definition'][0] != '500' &&
                                          data['noun or verb'][0] != '500') {
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
                                                data['pronunciation']['uk'][0]);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changePronunciationSoundUs(
                                                data['pronunciation']['us'][0]);
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
                                            .changeToDictionary(false);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .getWords();
                                      } else {
                                        message(context,
                                            'Sorry...Internet Server Error');
                                      }
                                    } catch (e) {
                                      message(context,
                                          'It looks like you\'ve lost your Internet connection');
                                    }
                                  } else {
                                    Provider.of<ValueManager>(context,
                                            listen: false)
                                        .changeShowModalHUD();
                                    message(context,
                                        'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                                  }
                                } else {
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeShowModalHUD();
                                  message(context,
                                      'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                                }
                              } else {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD();
                                message(context,
                                    'It looks like you\'ve lost your Internet connection');
                              }
                            } else {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowModalHUD();
                              message(context,
                                  'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).wordSearchDictionary}"');
                            }
                          } else {
                            Provider.of<ValueManager>(context, listen: false)
                                .changeSearchForEmpty(true);
                            Provider.of<ValueManager>(context, listen: false)
                                .changeShowModalHUD();
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.search,
                          color: Color(0xff98DED9),
                        )),
                    hintStyle: TextStyle(
                      fontFamily: "Carme",
                    ),
                    hintText: Provider.of<ValueManager>(context, listen: false)
                            .searchForEmpty
                        ? "Empty"
                        : "Tap here",
                    contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: 1,
                        color: Provider.of<ValueManager>(context, listen: false)
                                .searchForEmpty
                            ? Colors.redAccent
                            : Color(0xff98DED9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: Provider.of<ValueManager>(context, listen: false)
                                .searchForEmpty
                            ? 1.5
                            : 2,
                        color: Provider.of<ValueManager>(context, listen: false)
                                .searchForEmpty
                            ? Colors.redAccent
                            : Color(0xff98DED9),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: Text(
                    'Recent',
                    style: TextStyle(
                      color: kBlue,
                      fontSize: 40,
                      fontFamily: "Carme",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Provider.of<ValueManager>(context, listen: false)
                            .dictionaryTranslatorDataList
                            .length >
                        0
                    ? Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textS(Provider.of<ValueManager>(context,
                                    listen: false)
                                .dictionaryTranslatorDataList[
                                    Provider.of<ValueManager>(context,
                                                listen: false)
                                            .dictionaryTranslatorDataList
                                            .length -
                                        1]
                                .word),
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      )
                    : Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            'No word',
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      ),
                Provider.of<ValueManager>(context, listen: false)
                            .dictionaryTranslatorDataList
                            .length >
                        1
                    ? Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textS(Provider.of<ValueManager>(context,
                                    listen: false)
                                .dictionaryTranslatorDataList[
                                    Provider.of<ValueManager>(context,
                                                listen: false)
                                            .dictionaryTranslatorDataList
                                            .length -
                                        2]
                                .word),
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      )
                    : Container(width: double.infinity),
                Provider.of<ValueManager>(context, listen: false)
                            .dictionaryTranslatorDataList
                            .length >
                        2
                    ? Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textS(Provider.of<ValueManager>(context,
                                    listen: false)
                                .dictionaryTranslatorDataList[
                                    Provider.of<ValueManager>(context,
                                                listen: false)
                                            .dictionaryTranslatorDataList
                                            .length -
                                        3]
                                .word),
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      )
                    : Container(width: double.infinity),
                Provider.of<ValueManager>(context, listen: false)
                            .dictionaryTranslatorDataList
                            .length >
                        3
                    ? Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textS(Provider.of<ValueManager>(context,
                                    listen: false)
                                .dictionaryTranslatorDataList[
                                    Provider.of<ValueManager>(context,
                                                listen: false)
                                            .dictionaryTranslatorDataList
                                            .length -
                                        4]
                                .word),
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      )
                    : Container(width: double.infinity),
                Provider.of<ValueManager>(context, listen: false)
                            .dictionaryTranslatorDataList
                            .length >
                        4
                    ? Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textS(Provider.of<ValueManager>(context,
                                    listen: false)
                                .dictionaryTranslatorDataList[
                                    Provider.of<ValueManager>(context,
                                                listen: false)
                                            .dictionaryTranslatorDataList
                                            .length -
                                        5]
                                .word),
                            style: TextStyle(
                              fontFamily: "Carme",
                            ),
                          ),
                        ),
                      )
                    : Container(width: double.infinity),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
