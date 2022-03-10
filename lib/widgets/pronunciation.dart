import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pronunciation extends StatelessWidget {
  final String pronunciation;
  final Function function;
  Pronunciation({this.pronunciation, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          Text(
            pronunciation,
            style: TextStyle(
              color: kBlueSearchWord,
              fontSize: 12,
              //fontFamily: "Carme",
              //fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            FontAwesomeIcons.volumeUp,
            size: 14,
            color: kBlueSearchWord,
          )
        ],
      ),
    );
  }
}
