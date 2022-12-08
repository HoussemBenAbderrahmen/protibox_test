import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:proti_box/action_button.dart';
import 'package:proti_box/auth.dart';
import 'package:proti_box/screens/forgot_password.dart';

import '../custom_edit_text.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);
  static const String routeName = "/SignInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final List<TextEditingController> controllers = [];

  bool rememberMe = true;
  Function? onPressed;

  @override
  void initState() {
    super.initState();
    controllers.add(codeController);
    controllers.add(pwdController);
    controllers.forEach((controller) {
      controller.addListener(() {
        bool isThereEmpty =
            controllers.firstWhereOrNull((element) => element.text.isEmpty) !=
                null;
        setState(() {
          onPressed = !isThereEmpty
              ? () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              : null;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((element) {
      element.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Auth(
      isBackBtnShown: false,
      children: [
        Text(
          "Content de vous revoir",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Entrez votre contact pour se connecter",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black54),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomEditText(
          controller: codeController,
          label: "Code Conducteur",
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16),
        CustomEditText(
          controller: pwdController,
          label: "Mot de passe",
          isObscure: true,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            GestureDetector(
              onTap: (() {
                Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
              }),
              child: Text(
                "Mot de passe oublié?",
              ),
            ),
            Spacer(),
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState((){
                      rememberMe = !rememberMe;
                    });
                  }),
            ),
            SizedBox(width: 4,),
            Text("Se souvenir de mois")
          ],
        ),
      ],
      floatingChild: ActionButton(text: "Se connecter", onPressed: onPressed),
    );
  }
}
