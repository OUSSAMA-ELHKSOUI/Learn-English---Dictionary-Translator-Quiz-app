import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:flutter/cupertino.dart';

class DoneRemainText extends StatelessWidget {
  final int remain;
  final int done;
  DoneRemainText({this.done, this.remain});
  @override
  Widget build(BuildContext context) {
    return Text(
      done > 1
          ? '$done are done $remain remain'
          : '$done is done $remain remain',
      style: TextStyle(color: kGreyTexts, fontSize: 20, fontFamily: 'Carme'),
    );
  }
}
