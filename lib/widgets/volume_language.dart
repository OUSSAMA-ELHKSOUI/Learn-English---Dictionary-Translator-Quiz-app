import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VolumeLanguage extends StatelessWidget {
  VolumeLanguage({this.language, this.times});
  final String language;
  final bool times;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            Text(
              language,
              style: TextStyle(color: kBlue, fontFamily: 'Carme', fontSize: 14),
            )
          ],
        ),
        times
            ? GestureDetector(
                onTap: () {
                  Provider.of<ValueManager>(context, listen: false)
                      .changeText('');
                  Provider.of<ValueManager>(context, listen: false)
                      .changeTextTranslated([]);
                  Provider.of<ValueManager>(context, listen: false)
                      .changeAfterPressingButtonTranslator(true);
                },
                child: Icon(
                  FontAwesomeIcons.times,
                  color: kBlue,
                  size: 19,
                ),
              )
            : Container(
                height: 1,
              ),
      ],
    );
  }
}
