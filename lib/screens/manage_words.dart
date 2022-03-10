import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/backArrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/term_of_use.dart';
import 'package:provider/provider.dart';

class ManageWords extends StatelessWidget {
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

  String makeLines(List<dynamic> def, BuildContext context) {
    String text = "";
    for (int i = 0; i < def.length; i++) {
      text += '${i + 1}. ${def[i].trimRight().trimLeft()}\n';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackGroundDicColor,
        appBar: AppBar(
          backgroundColor: kBackGroundDicColor,
          elevation: 0,
          leading: BackArrow(
            color: kBlue,
            function: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Words',
            style: TextStyle(color: kBlue, fontSize: 25, fontFamily: 'Carme'),
          ),
        ),
        bottomNavigationBar: Container(
          child: TermsOfUse(),
        ),
        body: Consumer<ValueManager>(
          builder: (context, data, child) {
            // Future.delayed(Duration.zero, () async {
            //   data.refrich();
            // });
            //data.getTasks();
            return data.dictionaryTranslatorDataList.length == 0
                ? Center(
                    child: Text(
                      'No word',
                      style: TextStyle(
                        color: kGreyComment,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Carme",
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Theme(
                        data: Theme.of(context).copyWith(accentColor: kBlue),
                        child: ExpansionTile(
                          title: Text(textS(data
                              .dictionaryTranslatorDataList[
                                  data.dictionaryTranslatorDataList.length -
                                      index -
                                      1]
                              .word)),
                          subtitle: Text(data
                              .dictionaryTranslatorDataList[
                                  data.dictionaryTranslatorDataList.length -
                                      index -
                                      1]
                              .fromWhere),
                          children: [
                            ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  data.deleteTask(
                                      data
                                          .dictionaryTranslatorDataList[data
                                                  .dictionaryTranslatorDataList
                                                  .length -
                                              index -
                                              1]
                                          .word,
                                      data
                                          .dictionaryTranslatorDataList[data
                                                  .dictionaryTranslatorDataList
                                                  .length -
                                              index -
                                              1]
                                          .fromWhere,
                                      data.dictionaryTranslatorDataList[data
                                              .dictionaryTranslatorDataList
                                              .length -
                                          index -
                                          1]);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeAfterPressingButton(true);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .changeAfterPressingButtonTranslator(
                                          true);
                                  Provider.of<ValueManager>(context,
                                          listen: false)
                                      .getWords();
                                },
                                child: Icon(
                                  FontAwesomeIcons.trash,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              title: Text("Definitions and Synonyms"),
                              subtitle: Text(makeLines(
                                  data
                                      .dictionaryTranslatorDataList[data
                                              .dictionaryTranslatorDataList
                                              .length -
                                          index -
                                          1]
                                      .definitionOrTranslation,
                                  context)),
                            ),
                          ],
                        ),
                      );
                      //   changeTriggerCheckbox: () {
                      //     data.changeIsCheckedInDictionaryTranslatorData(
                      //         data.dictionaryTranslatorDataList[
                      //         data.dictionaryTranslatorDataList.length - index]);
                      //     if (data
                      //         .dictionaryTranslatorDataList[
                      //     data.dictionaryTranslatorDataList.length - index]
                      //         .isChecked) {
                      //       data.addToCheckedInDictionaryTranslatorDataListChecked(
                      //           data.dictionaryTranslatorDataList[
                      //           data.dictionaryTranslatorDataList.length -
                      //               index]);
                      //     } else {
                      //       if (data.dictionaryTranslatorDataListChecked.contains(data
                      //           .dictionaryTranslatorDataList[
                      //       data.dictionaryTranslatorDataList.length - index])) {
                      //         data.removeFromCheckedInDictionaryTranslatorDataListChecked(
                      //             data.dictionaryTranslatorDataList[
                      //             data.dictionaryTranslatorDataList.length -
                      //                 index]);
                      //       }
                      //     }
                      //     if (data.dictionaryTranslatorDataListChecked.length == 0) {
                      //       Provider.of<ValueManager>(context, listen: false)
                      //           .changeAllWordChecked(true);
                      //     }
                      //   },
                      // )
                    },
                    itemCount: data.dictionaryTranslatorDataList.length,
                    // scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    // physics: BouncingScrollPhysics(),
                  );
          },
        ),
      ),
    );
  }
}
