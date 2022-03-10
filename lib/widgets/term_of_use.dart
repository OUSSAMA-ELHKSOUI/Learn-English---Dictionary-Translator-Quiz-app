import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learnenglish_dtmwordswithquiz/widgets/policy_dialog.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By using this app, you are agreeing to our\n",
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: "Terms & Conditions ",
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terms_and_conditions.md',
                      );
                    },
                  );
                },
            ),
            TextSpan(text: "and "),
            TextSpan(
              text: "Privacy Policy! ",
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
