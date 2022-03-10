import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/services/admob_service.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/button_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TextFieldTranslatorSheet extends StatefulWidget {
  @override
  _TextFieldTranslatorSheetState createState() =>
      _TextFieldTranslatorSheetState();
}

class _TextFieldTranslatorSheetState extends State<TextFieldTranslatorSheet> {
  final ams = AdMobService();
  @override
  void initState() {
    super.initState();
    // TODO admob_flutter
    Admob.initialize();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  //autofocus: true,
                  onChanged: (value) {
                    Provider.of<ValueManager>(context, listen: false)
                        .changeSearchForEmptyText(false);
                    Provider.of<ValueManager>(context, listen: false)
                        .changeText(value);
                  },
                  decoration: InputDecoration(
                    hintText: Provider.of<ValueManager>(context, listen: false)
                            .searchForEmptyText
                        ? 'Empty'
                        : 'Enter text (${Provider.of<ValueManager>(context, listen: false).languageText})',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Provider.of<ValueManager>(context, listen: false)
                                      .searchForEmptyText
                                  ? Colors.redAccent
                                  : kButtonColor,
                          width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Provider.of<ValueManager>(context, listen: false)
                                      .searchForEmptyText
                                  ? Colors.redAccent
                                  : kButtonColor,
                          width:
                              Provider.of<ValueManager>(context, listen: false)
                                      .searchForEmptyText
                                  ? 1.5
                                  : 2),
                    ),
                  ),
                  maxLines: 5,
                  minLines: 5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Provider.of<ValueManager>(context, listen: false).showModalHUD3
                  ? ButtonApp(
                      textChild: 'Translate',
                      minWidth: double.infinity,
                      onPress: () async {
                        Provider.of<ValueManager>(context, listen: false)
                            .changeShowModalHUD3();
                        if (Provider.of<ValueManager>(context, listen: false)
                                .languageText !=
                            Provider.of<ValueManager>(context, listen: false)
                                .languageTextTranslated) {
                          //todo in python code : in translator class an if should be elif
                          if (Provider.of<ValueManager>(context, listen: false)
                                  .text !=
                              '') {
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
                              var data = await getTranslatorData(
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .text,
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .languageText,
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .languageTextTranslated);
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
                                                .changeTextTranslated(
                                                    data['translation']);
                                            FocusScope.of(context).unfocus();
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeSearchForEmptyText(
                                                    false);
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeToTextField(true);
                                            Navigator.pop(context);
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeShowModalHUD3();
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeAfterPressingButtonTranslator(
                                                    true);
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .getWords();
                                          } catch (e) {
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .changeShowModalHUD3();
                                            message(context,
                                                'It looks like you\'ve lost your Internet connection');
                                          }
                                        } else {
                                          Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .changeShowModalHUD3();
                                          message(context,
                                              'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                        }
                                      } else {
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeShowModalHUD3();
                                        message(context,
                                            'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                      }
                                    } else {
                                      Provider.of<ValueManager>(context,
                                              listen: false)
                                          .changeShowModalHUD3();
                                      message(context,
                                          'Sorry...Internet Server Error');
                                    }
                                  } catch (e) {
                                    // Provider.of<ValueManager>(context,
                                    //         listen: false)
                                    //     .changeText('');
                                    // Provider.of<ValueManager>(context,
                                    //         listen: false)
                                    //     .changeShowModalHUD3();
                                    // message(context,
                                    //     'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                  }
                                } else {
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeShowModalHUD3();
                                  message(context,
                                      'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                                }
                              } else {
                                Provider.of<ValueManager>(context,
                                        listen: false)
                                    .changeShowModalHUD3();
                                message(context,
                                    'It looks like you\'ve lost your Internet connection');
                              }
                            } else {
                              Provider.of<ValueManager>(context, listen: false)
                                  .changeShowModalHUD3();
                              message(context,
                                  'No exact matches found for "${Provider.of<ValueManager>(context, listen: false).text}"');
                            }
                          } else {
                            Provider.of<ValueManager>(context, listen: false)
                                .changeSearchForEmptyText(true);
                            Provider.of<ValueManager>(context, listen: false)
                                .changeShowModalHUD3();
                          }
                        } else {
                          Provider.of<ValueManager>(context, listen: false)
                              .changeTextTranslated(
                                  ['Please, specify two different languages']);
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                          Provider.of<ValueManager>(context, listen: false)
                              .changeToTextField(true);
                          Provider.of<ValueManager>(context, listen: false)
                              .changeShowModalHUD3();
                        }
                      },
                      size: 25,
                    )
                  : CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              // TODO admob_flutter
              AdmobBanner(
                adUnitId: ams.getBannerAdIdT1(),
                adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                    width: MediaQuery.of(context).size.width.toInt() - 41),
              ),
              SizedBox(
                height: 5,
              ),
              // AdmobBanner(
              //   adUnitId: ams.getBannerAdIdT2(),
              //   adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              //       width: MediaQuery.of(context).size.width.toInt() - 41),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // AdmobBanner(
              //   adUnitId: ams.getBannerAdIdT3(),
              //   adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              //       width: MediaQuery.of(context).size.width.toInt() - 41),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// todo khawya tradictiion unable add to qiuz button
