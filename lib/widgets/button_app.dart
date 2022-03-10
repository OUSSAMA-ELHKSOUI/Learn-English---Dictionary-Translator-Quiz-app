import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonApp extends StatelessWidget {
  ButtonApp(
      {this.textChild,
      this.onPress,
      this.minWidth,
      this.size,
      this.sizeAfterPressingButton = 15,
      this.afterPressingButton = true});

  final String textChild;
  final Function onPress;
  final double minWidth;
  final double size;
  final double sizeAfterPressingButton;
  final bool afterPressingButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: afterPressingButton ? kButtonColor : kGreyTexts,
      elevation: 3.0,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: minWidth,
        onPressed: onPress,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            afterPressingButton ? textChild : 'Already added',
            style: TextStyle(
              color: Colors.white,
              fontSize: afterPressingButton ? size : sizeAfterPressingButton,
              fontFamily: "Carme",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
