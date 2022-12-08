import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proti_box/action_button.dart';
import 'package:proti_box/auth.dart';
import 'package:proti_box/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_edit_text.dart';
import 'complete_account.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/WelcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController controller = TextEditingController();

  final Uri _url = Uri.parse('https://flutter.dev');
  Function? onPressed;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        onPressed = controller.text.isNotEmpty
            ? () {
                Navigator.pushNamed(context, CompleteAccountScreen.routeName);
              }
            : null;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themings.darkTheme.copyWith(primaryColor: createMaterialColor(Colors.white),textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white,
        selectionHandleColor: Colors.white,
      ),),
      home: Auth(
        isBackBtnShown: false,
        children: [
          Text(
            "Bienvenue à ProtiBox",
            style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
          ),
          Text(
            "Entrez votre code conducteur",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomEditText(controller: controller, label: "Code Conducteur"),
        ],
        floatingChild: SizedBox(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionButton(text: "Se connecter", onPressed: onPressed),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'En cliquant sur \"Se connecter\", vous acceptez les ',
                  // style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Conditions d\'utilisation',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = _launchUrl),
                    TextSpan(text: ' et la '),
                    TextSpan(
                        text: 'Charte de confidnetialité',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = _launchUrl),
                    TextSpan(text: ' de ProtiBox'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
