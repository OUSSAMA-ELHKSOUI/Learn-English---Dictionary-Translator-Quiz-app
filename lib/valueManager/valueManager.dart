import 'dart:math';
import 'package:learnenglish_dtmwordswithquiz/database/sql.dart';
import 'package:flutter/cupertino.dart';

import '../dictionary_translator_data.dart';

class ValueManager extends ChangeNotifier {
  bool toDictionary = true;
  bool toTextField = true;
  bool existWordToQuiz = false;

  String wordSearchDictionary = '';

  String word;
  String pronunciationWordUs = 'us';
  String pronunciationWordUk = 'uk';
  String pronunciationSoundUs;
  String pronunciationSoundUk;
  List<dynamic> definitions;
  List<dynamic> examples;
  List<dynamic> synonyms;
  List<dynamic> moreExample;
  List<dynamic> moreDefinition;
  List<dynamic> nounOrVerb;

  String languageText = 'English';
  String languageTextTranslated = 'English';

  String text = '';
  List<dynamic> textTranslated = [];

  bool showModalHUD = false;
  bool showModalHUD2 = false;
  bool showModalHUD3 = true;
  bool showModalHUD4 = false;

  bool searchForEmpty = false;
  bool searchForEmptyText = false;

  Sql sql = Sql();

  List<DictionaryTranslatorData> dictionaryTranslatorDataList = [];
  List<String> wordList = [];
  List<DictionaryTranslatorData> dictionaryTranslatorDataListChecked = [];

  List<String> randomWords = [
    'ability',
    'aim',
    'alike',
    'afterwards',
    'baggage',
    'banking',
    'blouse',
    'bulb',
    'cabbage',
    'careful',
    'cashpoint',
    'charming',
    'cathedral',
    'complaint',
    'desert',
    'disease',
    'diary',
    'dish',
    'evening',
    'elder',
    'elbow',
    'enquiry',
    'fasten',
    'finger',
    'frog',
    'fountain',
    'glove',
    'granny',
    'gum',
    'humid',
  ];

  bool allWordChecked = true;

  bool checkAnswer = false;

  bool showAddToQuizButton = true;

  bool cardTest = true;
  bool cardTest1 = true;
  bool cardTest2 = true;
  bool cardTest3 = true;

  bool afterPressingButton = true;
  bool afterPressingButtonTranslator = true;

  void changeAfterPressingButtonTranslator(bool value) {
    afterPressingButtonTranslator = value;
    notifyListeners();
  }

  void changeAfterPressingButton(bool value) {
    afterPressingButton = value;
    notifyListeners();
  }

  void addTask(
      String word, String fromWhere, List<String> definitionOrTranslation) {
    dictionaryTranslatorDataList.add(DictionaryTranslatorData(
        word: word,
        fromWhere: fromWhere,
        definitionOrTranslation: definitionOrTranslation));
    sql.save(DictionaryTranslatorData(
        word: word,
        fromWhere: fromWhere,
        definitionOrTranslation: definitionOrTranslation));
    notifyListeners();
  }

  void deleteTask(String word, String fromWhere,
      DictionaryTranslatorData dictionaryTranslatorData) {
    dictionaryTranslatorDataList.remove(dictionaryTranslatorData);
    if (dictionaryTranslatorDataListChecked
        .contains(dictionaryTranslatorData)) {
      dictionaryTranslatorDataListChecked.remove(dictionaryTranslatorData);
      if (dictionaryTranslatorDataListChecked.length == 0) {
        allWordChecked = true;
      }
    }
    sql.delete(word, fromWhere);
    notifyListeners();
  }

  void getTasks() async {
    dictionaryTranslatorDataList = await sql.getTasks();
    notifyListeners();
  }

  void getWords() async {
    wordList = await sql.getWords();
    notifyListeners();
  }

  void changeCardTest(bool value) {
    cardTest = value;
    notifyListeners();
  }

  void changeCardTest1(bool value) {
    cardTest1 = value;
    notifyListeners();
  }

  void changeCardTest2(bool value) {
    cardTest2 = value;
    notifyListeners();
  }

  void changeCardTest3(bool value) {
    cardTest3 = value;
    notifyListeners();
  }

  void changeShowAddToQuizButton(bool value) {
    showAddToQuizButton = value;
    notifyListeners();
  }

  void changeCheckAnswer(bool value) {
    checkAnswer = value;
    notifyListeners();
  }

  void changeAllWordChecked(bool value) {
    allWordChecked = value;
    notifyListeners();
  }

  void addToCheckedInDictionaryTranslatorDataListChecked(
      DictionaryTranslatorData value) {
    dictionaryTranslatorDataListChecked.add(value);
    notifyListeners();
  }

  void removeFromCheckedInDictionaryTranslatorDataListChecked(
      DictionaryTranslatorData value) {
    dictionaryTranslatorDataListChecked.remove(value);
    notifyListeners();
  }

  void changeIsCheckedInDictionaryTranslatorData(
      DictionaryTranslatorData value) {
    value.checked();
    notifyListeners();
  }

  void changeSearchForEmptyText(bool value) {
    searchForEmptyText = value;
    notifyListeners();
  }

  void changeSearchForEmpty(bool value) {
    searchForEmpty = value;
    notifyListeners();
  }

  void changeShowModalHUD4() {
    showModalHUD4 = !showModalHUD4;
    notifyListeners();
  }

  void changeShowModalHUD3() {
    showModalHUD3 = !showModalHUD3;
    notifyListeners();
  }

  void changeShowModalHUD2() {
    showModalHUD2 = !showModalHUD2;
    notifyListeners();
  }

  void changeShowModalHUD() {
    showModalHUD = !showModalHUD;
    notifyListeners();
  }

  void changeText(String value) {
    text = value;
    notifyListeners();
  }

  void changeTextTranslated(List<dynamic> value) {
    textTranslated = value;
    notifyListeners();
  }

  void changeLanguageText(String value) {
    languageText = value;
    notifyListeners();
  }

  void changeLanguageTextTranslated(String value) {
    languageTextTranslated = value;
    notifyListeners();
  }

  void changeNounOrVerb(List<dynamic> value) {
    nounOrVerb = value;
    notifyListeners();
  }

  void changeMoreExamples(List<dynamic> value) {
    moreExample = value;
    notifyListeners();
  }

  void changeMoreDefinitions(List<dynamic> value) {
    moreDefinition = value;
    notifyListeners();
  }

  void changeSynonyms(List<dynamic> value) {
    synonyms = value;
    notifyListeners();
  }

  void changeDefinitions(List<dynamic> value) {
    definitions = value;
    notifyListeners();
  }

  void changeExamples(List<dynamic> value) {
    examples = value;
    notifyListeners();
  }

  void changePronunciationWordUs(String value) {
    pronunciationWordUs = value;
    notifyListeners();
  }

  void changePronunciationWordUk(String value) {
    pronunciationWordUk = value;
    notifyListeners();
  }

  void changePronunciationSoundUs(String value) {
    pronunciationSoundUs = value;
    notifyListeners();
  }

  void changePronunciationSoundUk(String value) {
    pronunciationSoundUk = value;
    notifyListeners();
  }

  void changeWordSearchDictionary(String value) {
    wordSearchDictionary = value;
    notifyListeners();
  }

  void changeWord(String value) {
    word = value;
    notifyListeners();
  }

  void changeToDictionary(bool value) {
    toDictionary = value;
    notifyListeners();
  }

  void changeToTextField(bool value) {
    toTextField = value;
    notifyListeners();
  }

  void changeExistWordToQuiz(bool value) {
    existWordToQuiz = value;
    notifyListeners();
  }

  void refrich() {
    notifyListeners();
  }
}
