import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownButtonApp extends StatelessWidget {
  final String language;
  final Function changeLanguage;
  DropdownButtonApp({this.language, this.changeLanguage});
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text(
            'English',
          ),
          value: 'English',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Arabic',
          ),
          value: 'Arabic',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'French',
          ),
          value: 'French',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Italian',
          ),
          value: 'Italian',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Japanese',
          ),
          value: 'Japanese',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Russian',
          ),
          value: 'Russian',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Hindi',
          ),
          value: 'Hindi',
        ),
        DropdownMenuItem<String>(
          child: Text(
            'Indonesian',
          ),
          value: 'Indonesian',
        )
      ],
      underline: Container(
        height: 0,
      ),
      style: TextStyle(
        color: kBlue,
        fontFamily: 'Carme',
      ),
      iconEnabledColor: kBlue,
      onChanged: changeLanguage,
      value: language,
    );
  }
}
