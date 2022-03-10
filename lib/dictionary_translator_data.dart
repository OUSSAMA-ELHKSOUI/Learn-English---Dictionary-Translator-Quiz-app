class DictionaryTranslatorData {
  //int id;
  String word;
  List<String> definitionOrTranslation;
  bool isChecked;
  String fromWhere;

  DictionaryTranslatorData(
      {this.word,
      this.definitionOrTranslation,
      this.isChecked = false,
      this.fromWhere});

  void checked() {
    isChecked = !isChecked;
  }
}
