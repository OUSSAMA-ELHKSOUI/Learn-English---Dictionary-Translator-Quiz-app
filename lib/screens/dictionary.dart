import 'package:admob_flutter/admob_flutter.dart';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/bares.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/button_app.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/defAndExa.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/pronunciation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:learnenglish_dtmwordswithquiz/services/admob_service.dart';

class Dictionary extends StatefulWidget {
  final TabController tabController;

  Dictionary({this.tabController});
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  AudioPlayer audioPlayer;
  AudioPlayer audioPlayer2;
  Future<bool> pressBackButton(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'do you want to chose an other word',
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
                    if (Provider.of<ValueManager>(context, listen: false)
                            .showModalHUD2 ==
                        true) {
                      Provider.of<ValueManager>(context, listen: false)
                          .changeShowModalHUD2();
                    }
                    Provider.of<ValueManager>(context, listen: false)
                        .changeWordSearchDictionary('');
                    Provider.of<ValueManager>(context, listen: false)
                        .changeToDictionary(true);
                    Navigator.pop(context, false);
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
                    if (Provider.of<ValueManager>(context, listen: false)
                            .showModalHUD2 ==
                        true) {
                      Provider.of<ValueManager>(context, listen: false)
                          .changeShowModalHUD2();
                    }
                    Provider.of<ValueManager>(context, listen: false)
                        .changeWordSearchDictionary('');
                    Provider.of<ValueManager>(context, listen: false)
                        .changeToDictionary(true);
                    Navigator.pop(context, false);
                    widget.tabController
                        .animateTo((widget.tabController.index + 1));
                  },
                ),
              ],
            ));
  }

  final ams = AdMobService();
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer2 = AudioPlayer();
    //WidgetsFlutterBinding.ensureInitialized();
    // TODO admob_flutter
    Admob.initialize();
  }

  @override
  Widget build(BuildContext context) {
    int numbNounOrVerb =
        Provider.of<ValueManager>(context, listen: false).nounOrVerb.length >= 3
            ? 3
            : Provider.of<ValueManager>(context, listen: false)
                .nounOrVerb
                .length;
    int numbSynonym =
        Provider.of<ValueManager>(context, listen: false).synonyms.length;
    int numbMoreExample =
        Provider.of<ValueManager>(context, listen: false).moreExample.length;
    int numbMoreDefinition =
        Provider.of<ValueManager>(context, listen: false).moreDefinition.length;
    return WillPopScope(
      onWillPop: () async => pressBackButton(context),
      child: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall:
              Provider.of<ValueManager>(context, listen: false).showModalHUD2,
          child: Scaffold(
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
                  Provider.of<ValueManager>(context, listen: false)
                      .changeWordSearchDictionary('');
                  Provider.of<ValueManager>(context, listen: false)
                      .changeToDictionary(true);
                },
              ),
            ),
            backgroundColor: kBackGroundDicColor,
            body: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 150),
                  children: [
                    // TODO admob_flutter
                    AdmobBanner(
                      adUnitId: ams.getBannerAdId(),
                      adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                          width:
                              MediaQuery.of(context).size.width.toInt() - 41),
                    ),
                    SizedBox(height: 5),
                    for (int i = 0; i < numbNounOrVerb; i++)
                      Column(
                        children: [
                          Container(width: double.infinity),
                          Provider.of<ValueManager>(context, listen: false)
                                      .definitions[0] ==
                                  "definitionWithWordToSearch"
                              ? DefAndExa(
                                  numbDefinition: i + 1,
                                  definitionList: Provider.of<ValueManager>(
                                          context,
                                          listen: false)
                                      .definitions[i + 1],
                                  example:
                                      '${Provider.of<ValueManager>(context, listen: false).examples[i]}'
                                          .replaceAll('&#39;', "'"),
                                  nounOrVerb: Provider.of<ValueManager>(context,
                                          listen: false)
                                      .nounOrVerb[i]
                                      .trimRight()
                                      .trimLeft(),
                                )
                              : DefAndExa(
                                  numbDefinition: i + 1,
                                  definition:
                                      '${Provider.of<ValueManager>(context, listen: false).definitions[i]}'
                                          .replaceAll('&#39;', "'"),
                                  example:
                                      '${Provider.of<ValueManager>(context, listen: false).examples[i]}'
                                          .replaceAll('&#39;', "'"),
                                  nounOrVerb: Provider.of<ValueManager>(context,
                                          listen: false)
                                      .nounOrVerb[i]
                                      .trimRight()
                                      .trimLeft(),
                                ),
                          if (i < numbNounOrVerb - 1)
                            SizedBox(
                                child: Divider(
                                  height: 8,
                                  color: Color(0xffC7FFD8),
                                ),
                                height: 15),
                        ],
                      ),
                    // SizedBox(height: 5),
                    // AdmobBanner(
                    //   adUnitId: ams.getBannerAdId2(),
                    //   adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                    //       width:
                    //           MediaQuery.of(context).size.width.toInt() - 41),
                    // ),
                    // SizedBox(height: 5),
                    SizedBox(
                        child: Divider(
                          height: 8,
                          color: kBlue,
                        ),
                        height: 15),
                    Text(
                      'synonyms'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    for (int i = 0; i < numbSynonym; i++)
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Provider.of<ValueManager>(context, listen: false)
                                    .synonyms[0] ==
                                ""
                            ? Text(
                                'No synonyms',
                                style: TextStyle(
                                  color: kGreyComment,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Carme",
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: '${i + 1}. ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlueSearchWord),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${Provider.of<ValueManager>(context, listen: false).synonyms[i]}'
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
                              ),
                      ),
                    // SizedBox(
                    //     child: Divider(
                    //       height: 8,
                    //       color: Color(0xffC7FFD8),
                    //     ),
                    //     height: 10),
                    // AdmobBanner(
                    //   adUnitId: ams.getBannerAdId3(),
                    //   adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                    //       width:
                    //           MediaQuery.of(context).size.width.toInt() - 41),
                    // ),
                    SizedBox(
                        child: Divider(
                          height: 8,
                          color: Color(0xffC7FFD8),
                        ),
                        height: 10),
                    Text(
                      'more definitions'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    for (int i = 0; i < numbMoreDefinition; i++)
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Provider.of<ValueManager>(context, listen: false)
                                    .moreDefinition[0] ==
                                ""
                            ? Text(
                                'No more definitions',
                                style: TextStyle(
                                  color: kGreyComment,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Carme",
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: '${i + 1}. ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlueSearchWord),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${Provider.of<ValueManager>(context, listen: false).moreDefinition[i]}'
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
                              ),
                      ),
                    // SizedBox(
                    //     child: Divider(
                    //       height: 8,
                    //       color: Color(0xffC7FFD8),
                    //     ),
                    //     height: 10),
                    // AdmobBanner(
                    //   adUnitId: ams.getBannerAdId4(),
                    //   adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                    //       width:
                    //           MediaQuery.of(context).size.width.toInt() - 41),
                    // ),
                    SizedBox(
                        child: Divider(
                          height: 8,
                          color: Color(0xffC7FFD8),
                        ),
                        height: 10),
                    Text(
                      'more examples'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: "Carme",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    for (int i = 0; i < numbMoreExample; i++)
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Provider.of<ValueManager>(context, listen: false)
                                    .moreExample[0] ==
                                ""
                            ? Text(
                                'No more examples',
                                style: TextStyle(
                                  color: kGreyComment,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Carme",
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: '${i + 1}. ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlueSearchWord),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${Provider.of<ValueManager>(context, listen: false).moreExample[i]}'
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
                              ),
                      ),
                    SizedBox(height: 10),
                    // TODO admob_flutter
                    AdmobBanner(
                      adUnitId: ams.getBannerAdId4(),
                      adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                          width:
                              MediaQuery.of(context).size.width.toInt() - 41),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      color: kBackGroundDicColor,
                    ),
                    height: 130,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .word
                                                .trimRight()
                                                .trimLeft(),
                                            style: TextStyle(
                                              color: kBlue,
                                              fontSize: 45,
                                              fontFamily: "Carme",
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Pronunciation(
                                            pronunciation:
                                                Provider.of<ValueManager>(
                                                                context,
                                                                listen: false)
                                                            .pronunciationWordUk
                                                            .trimRight()
                                                            .trimLeft() !=
                                                        'UK 500'
                                                    ? Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .pronunciationWordUk
                                                        .trimRight()
                                                        .trimLeft()
                                                    : '',
                                            function: () async {
                                              if (Provider.of<ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .pronunciationSoundUk
                                                      .trimRight()
                                                      .trimLeft() !=
                                                  'UK 500') {
                                                await audioPlayer.play(
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .pronunciationSoundUk
                                                        .trimRight()
                                                        .trimLeft());
                                              }
                                              // await audioPlayer.play(
                                              //     "https://lex-audio.useremarkable.com/mp3/to_gb_5.mp3");
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Pronunciation(
                                              pronunciation: Provider.of<
                                                                  ValueManager>(
                                                              context,
                                                              listen: false)
                                                          .pronunciationWordUs
                                                          .trimRight()
                                                          .trimLeft() !=
                                                      'US 500'
                                                  ? Provider.of<ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .pronunciationWordUs
                                                      .trimRight()
                                                      .trimLeft()
                                                  : '',
                                              function: () async {
                                                String pronunciationSoundUs =
                                                    Provider.of<ValueManager>(
                                                            context,
                                                            listen: false)
                                                        .pronunciationSoundUs
                                                        .trimRight()
                                                        .trimLeft();
                                                if (pronunciationSoundUs !=
                                                    'US 500') {
                                                  await audioPlayer2.play(
                                                      pronunciationSoundUs);
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ButtonApp(
                                    minWidth: 100,
                                    textChild: 'Add to QUIZ',
                                    size: 20,
                                    afterPressingButton: !Provider.of<
                                                    ValueManager>(context,
                                                listen: false)
                                            .wordList
                                            .contains(
                                                '${Provider.of<ValueManager>(context, listen: false).word.trimRight().trimLeft().toLowerCase()}From Dictionary') &&
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .afterPressingButton,
                                    onPress: () {
                                      if (!Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .wordList
                                              .contains(
                                                  '${Provider.of<ValueManager>(context, listen: false).word.trimRight().trimLeft().toLowerCase()}From Dictionary') &&
                                          Provider.of<ValueManager>(context,
                                                  listen: false)
                                              .afterPressingButton) {
                                        List<String> def = [];
                                        for (int i = 0;
                                            i < numbNounOrVerb;
                                            i++) {
                                          Provider.of<ValueManager>(context,
                                                          listen: false)
                                                      .definitions[0] ==
                                                  "definitionWithWordToSearch"
                                              ? def.add(
                                                  '${Provider.of<ValueManager>(context, listen: false).definitions[i + 1][0]} ${Provider.of<ValueManager>(context, listen: false).definitions[i + 1][1]}')
                                              : def.add(
                                                  '${Provider.of<ValueManager>(context, listen: false).definitions[i]}'
                                                      .replaceAll(
                                                          '&#39;', "'"));
                                        }
                                        if (!(Provider.of<ValueManager>(context,
                                                    listen: false)
                                                .synonyms[0] ==
                                            "")) {
                                          for (int i = 0;
                                              i <
                                                  Provider.of<ValueManager>(
                                                          context,
                                                          listen: false)
                                                      .synonyms
                                                      .length;
                                              i++) {
                                            def.add(Provider.of<ValueManager>(
                                                    context,
                                                    listen: false)
                                                .synonyms[i]
                                                .replaceAll('&#39;', "'"));
                                          }
                                        }
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .addTask(
                                                Provider.of<ValueManager>(
                                                        context,
                                                        listen: false)
                                                    .word
                                                    .trimRight()
                                                    .trimLeft()
                                                    .toLowerCase(),
                                                'From Dictionary',
                                                def);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .getWords();
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeExistWordToQuiz(true);
                                        Provider.of<ValueManager>(context,
                                                listen: false)
                                            .changeAfterPressingButton(false);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
