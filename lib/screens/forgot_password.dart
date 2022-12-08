import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:proti_box/action_button.dart';
import 'package:proti_box/auth.dart';

import '../custom_edit_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = "/ForgotPasswordScreen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController getCodeController = TextEditingController();

  Function? onPressed;
  Function? onCheckPressed;

  late StatefulBuilder errorDialog;

  @override
  void initState() {
    super.initState();
    getCodeController.addListener(() {
      setState(() {
        onPressed = getCodeController.text.isNotEmpty
            ? () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => errorDialog);
              }
            : null;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    errorDialog = StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            //this right here
            child: Container(
              height: 200.0,
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  OTPTextField(
                    length: 4,
                    width: 200,
                    fieldWidth: 34,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (s) {
                      setState(() {
                        onCheckPressed = s.length == 4
                            ? () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName);
                              }
                            : null;
                      });
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ActionButton(
                    text: "Vérifier",
                    onPressed: onCheckPressed,
                    isWidthInfinite: false,
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
    getCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Auth(
      isBackBtnShown: false,
      children: [
        Text(
          "Mot de passe oublié",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Veuillez saisir votre adresse e-mail.\nNous vous enverrons un e-mail pour réinitialiser votre mot de passe",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.black54),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomEditText(
          controller: getCodeController,
          label: "Votre adresse mail",
          textInputAction: TextInputAction.next,
        ),
      ],
      floatingChild: ActionButton(text: "Obtenir code", onPressed: onPressed),
    );
  }
}
