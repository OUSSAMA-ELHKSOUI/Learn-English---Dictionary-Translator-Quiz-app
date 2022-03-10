import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardApp extends StatelessWidget {
  final Function function;
  final IconData icon;
  final String name;
  CardApp({this.function, this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.width / 3 - 15,
          width: MediaQuery.of(context).size.width / 3 - 15,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: kBorderCard, width: 4),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: kBorderCard,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: kBorderCard,
                    fontFamily: 'Carme',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
