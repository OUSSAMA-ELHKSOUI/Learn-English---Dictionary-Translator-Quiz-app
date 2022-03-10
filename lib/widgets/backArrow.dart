import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackArrow extends StatelessWidget {
  final Color color;
  final Function function;

  BackArrow({this.color, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Icon(
        FontAwesomeIcons.arrowLeft,
        color: color,
        size: 32,
      ),
    );
  }
}
