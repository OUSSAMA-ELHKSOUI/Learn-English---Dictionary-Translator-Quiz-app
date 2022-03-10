import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/button_app.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/dropdown_button_app.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/volume_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'text_field_translator_sheet.dart';

class Translator extends StatefulWidget {
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  String lineTranslated(List<dynamic> data) {
    String line = '';
    for (int i = 0; i < data.length; i++) {
      line += '"${data[i]}", ';
    }
    return line;
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

  Future getTranslatorData(
      String word, String langText, String langTransText) async {
    String url =
        'url that fetch definitions, examples and synonyms of an English word';

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall:
            Provider.of<ValueManager>(context, listen: false).showModalHUD4,
        child: Scaffold(
          backgroundColor: kGreyBackGround,
          appBar: AppBar(
            backgroundColor: kBlue,
            title: Text(
              'Translator',
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
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: kBackGroundDicColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonApp(
                          language:
                              Provider.of<ValueManager>(context, listen: false)
                                  .languageText,
                          changeLanguage: (value) {
                            if (value != 'English') {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowAddToQuizButton(false);
                            } else {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowAddToQuizButton(true);
                            }
                            if (Provider.of<ValueManager>(context,
                                        listen: false)
                                    .textTranslated
                                    .contains(
                                        'Please, specify two different languages') &&
                                Provider.of<ValueManager>(context,
                                            listen: false)
                                        .languageText !=
                                    value) {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeTextTranslated([]);
                            }
                            if (Provider.of<ValueManager>(context,
                                        listen: false)
                                    .text !=
                                '') {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeTextTranslated([]);
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeText('');
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeAfterPressingButtonTranslator(true);
                            }
                            Provider.of<ValueManager>(context, listen: false)
                                .changeLanguageText(value);
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.exchangeAlt,
                            color: kBlue,
                            size: 20,
                          ),
                          onTap: () {
                            if (Provider.of<ValueManager>(context,
                                        listen: false)
                                    .languageTextTranslated !=
                                'English') {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowAddToQuizButton(false);
                            } else {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowAddToQuizButton(true);
                            }
                            String valueHelper = Provider.of<ValueManager>(
                                    context,
                                    listen: false)
                                .languageText;
                            Provider.of<ValueManager>(context, listen: false)
                                .changeLanguageText(Provider.of<ValueManager>(
                                        context,
                                        listen: false)
                                    .languageTextTranslated);
                            Provider.of<ValueManager>(context, listen: false)
                                .changeLanguageTextTranslated(valueHelper);
                            if (Provider.of<ValueManager>(context,
                                        listen: false)
                                    .languageText !=
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .languageTextTranslated) {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeTextTranslated([]);
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeText('');
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeAfterPressingButtonTranslator(true);
                            }
                          },
                        ),
                        DropdownButtonApp(
                          language:
                              Provider.of<ValueManager>(context, listen: false)
                                  .languageTextTranslated,
                          changeLanguage: (value) async {
                            if (Provider.of<ValueManager>(context,
                                        listen: false)
                                    .textTranslated
                                    .contains(
                                        'Please, specify two different languages') &&
                                Provider.of<ValueManager>(context,
                                            listen: false)
                                        .languageTextTranslated !=
                                    value) {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeTextTranslated([]);
                            }
                            if (Provider.of<ValueManager>(context,
                                            listen: false)
                                        .text !=
                                    '' &&
                                Provider.of<ValueManager>(context,
                                            listen: false)
                                        .languageTextTranslated !=
                                    value &&
                                Provider.of<ValueManager>(context,
                                            listen: false)
                                        .languageText !=
                                    value) {
                              if (!Provider.of<ValueManager>(context,
                                          listen: false)
                                      .text
                                      .contains('&') &&
                                  !Provider.of<ValueManager>(context,
                                          listen: false)
                                      .text
                                      .contains('*') &&
                                  !Provider.of<ValueManager>(context,
                                          listen: false)
                                      .text
                                      .contains('?') &&
                                  !Provider.of<ValueManager>(context,
                                          listen: false)
                                      .text
                                      .contains('/')) {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD4();
                                var data = await getTranslatorData(
                                    Provider.of<ValueManager>(context,
                                            listen: false)
                                        .text,
                                    Provider.of<ValueManager>(context,
                                            listen: false)
                                        .languageText,
                                    value);
                                if (data['translation'] != null) {
                                  if (data != {}) {
                                    try {
                                      if (data['translation'][0] != '500') {
                                        if (data['translation'][0] !=
                                            'hard to get it') {
                                          if (data['translation'][0] !=
                                              'word not find') {
                                            try {
                                              Provider.of<ValueManager>(context,
                                                      listen: false)
                                                  .changeShowModalHUD4();
                                              Provider.of<ValueManager>(context,
                                                      listen: false)
                                                  .changeTextTranslated(
                                                      data['translation']);
                                            } catch (e) {
                                              message(context,
                                                  'It looks like you\'ve lost your Internet connection');
                                            }
                                          } else {
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeShowModalHUD4();
                                            message(context,
                                                'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                          }
                                        } else {
                                          Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .changeShowModalHUD4();
                                          message(context,
                                              'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                        }
                                      } else {
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeShowModalHUD4();
                                        message(context,
                                            'Sorry...Internet Server Error');
                                      }
                                    } catch (e) {
                                      Provider.of<ValueManager>(context,
                                              listen: false)
                                          .changeShowModalHUD4();
                                      message(context,
                                          'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                    }
                                  } else {
                                    Provider.of<ValueManager>(context,
                                            listen: false)
                                        .changeShowModalHUD4();
                                    message(context,
                                        'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                  }
                                } else {
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeShowModalHUD4();
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeTextTranslated([]);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeText('');
                                  message(context,
                                      'It looks like you\'ve lost your Internet connection');
                                }
                              } else {
                                message(context,
                                    'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                              }
                            }
                            Provider.of<ValueManager>(context, listen: false)
                                .changeLanguageTextTranslated(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Material(
                  elevation: 3,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: VolumeLanguage(
                            language: Provider.of<ValueManager>(context,
                                    listen: false)
                                .languageText,
                            times: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          flex: 10,
                          child: GestureDetector(
                            child: ListView(
                              children: [
                                Text(
                                  Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .text ==
                                          ''
                                      ? 'Tap to enter text'
                                      : Provider.of<ValueManager>(context,
                                              listen: false)
                                          .text,
                                  style: TextStyle(
                                      fontFamily: "Carme",
                                      color: Provider.of<ValueManager>(context,
                                                      listen: false)
                                                  .text ==
                                              ''
                                          ? kGreyTexts
                                          : Colors.black,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (Provider.of<ValueManager>(context,
                                          listen: false)
                                      .showModalHUD3 ==
                                  false) {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD3();
                              }
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeText('');
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeTextTranslated([]);
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeSearchForEmptyText(false);
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeAfterPressingButtonTranslator(true);
                              Provider.of<ValueManager>(context, listen: false)
                                  .getWords();
                              // Provider.of<ValueManager>(context, listen: false)
                              // .changeToTextField(false);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: TextFieldTranslatorSheet()),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Material(
                    elevation: 3,
                    child: Container(
                      color: kBackGroundDicColor,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: VolumeLanguage(
                              language: Provider.of<ValueManager>(context,
                                      listen: false)
                                  .languageTextTranslated,
                              times: false,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            flex: 10,
                            child: Stack(
                              children: [
                                ListView(
                                  padding: EdgeInsets.only(bottom: 60),
                                  children: [
                                    Text(
                                      Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .textTranslated
                                              .isEmpty
                                          ? 'Translation'
                                          : lineTranslated(
                                              Provider.of<ValueManager>(context,
                                                      listen: false)
                                                  .textTranslated),
                                      style: TextStyle(
                                          fontFamily: "Carme",
                                          color: Provider.of<ValueManager>(
                                                      context,
                                                      listen: false)
                                                  .textTranslated
                                                  .isEmpty
                                              ? kGreyTexts
                                              : Colors.black,
                                          fontSize: 20),
                                      textDirection: (Provider.of<ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .languageTextTranslated ==
                                                  'Arabic' &&
                                              Provider.of<ValueManager>(context,
                                                      listen: false)
                                                  .textTranslated
                                                  .isNotEmpty &&
                                              !Provider.of<ValueManager>(
                                                      context,
                                                      listen: false)
                                                  .textTranslated
                                                  .contains(
                                                      'Please, specify two different languages'))
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                    ),
                                  ],
                                ),
                                Provider.of<ValueManager>(context,
                                            listen: false)
                                        .showAddToQuizButton
                                    ? Positioned(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.41,
                                        width: 314,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ButtonApp(
                                              minWidth: 100,
                                              textChild: 'Add to QUIZ',
                                              size: 13,
                                              sizeAfterPressingButton: 10,
                                              afterPressingButton: !Provider.of<
                                                              ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .wordList
                                                      .contains(
                                                          '${Provider.of<ValueManager>(context, listen: false).text.trimRight().trimLeft().toLowerCase()}From Translator') &&
                                                  Provider.of<ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .afterPressingButtonTranslator,
                                              onPress: () {
                                                if (Provider.of<ValueManager>(
                                                                context,
                                                                listen: false)
                                                            .text !=
                                                        '' &&
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .textTranslated
                                                        .isNotEmpty &&
                                                    !Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .textTranslated
                                                        .contains(
                                                            'Please, specify two different languages')) {
                                                  if (!Provider.of<
                                                                  ValueManager>(
                                                              context,
                                                              listen: false)
                                                          .wordList
                                                          .contains(
                                                              '${Provider.of<ValueManager>(context, listen: false).text.trimRight().trimLeft().toLowerCase()}From Translator') &&
                                                      Provider.of<ValueManager>(
                                                              context,
                                                              listen: false)
                                                          .afterPressingButtonTranslator) {
                                                    List<String> def = [];
                                                    // def.add(Provider.of<
                                                    //             ValueManager>(
                                                    //         context,
                                                    //         listen: false)
                                                    //     .languageTextTranslated);
                                                    def.add(lineTranslated(
                                                        Provider.of<ValueManager>(
                                                                context,
                                                                listen: false)
                                                            .textTranslated));
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .addTask(
                                                            Provider.of<ValueManager>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .text
                                                                .trimRight()
                                                                .trimLeft()
                                                                .toLowerCase(),
                                                            'From Translator',
                                                            def);
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .getWords();
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .changeExistWordToQuiz(
                                                            true);
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .changeAfterPressingButtonTranslator(
                                                            false);
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(width: double.infinity),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
