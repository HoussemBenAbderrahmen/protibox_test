import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:proti_box/action_button.dart';
import 'package:proti_box/auth.dart';
import 'package:proti_box/custom_edit_text.dart';
import 'package:proti_box/screens/signature.dart';

import '../theme.dart';

class CompleteAccountScreen extends StatefulWidget {
  CompleteAccountScreen({Key? key}) : super(key: key);
  static const String routeName = "/CompleteAccountScreen";

  @override
  State<CompleteAccountScreen> createState() => _CompleteAccountScreenState();
}

class _CompleteAccountScreenState extends State<CompleteAccountScreen> {
  final TextEditingController telController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController pwdController = TextEditingController();

  final TextEditingController pwdConfirmController = TextEditingController();
  final List<TextEditingController> controllers = [];

  Function? onPressed;

  @override
  void initState() {
    super.initState();
    controllers.add(telController);
    controllers.add(mailController);
    controllers.add(pwdController);
    controllers.add(pwdConfirmController);

    controllers.forEach((controller) {
      controller.addListener(() {
        bool isThereEmpty =
            controllers.firstWhereOrNull((element) => element.text.isEmpty) !=
                null;
        setState(() {
          onPressed = !isThereEmpty
              ? () {
                  Navigator.pushNamed(context, SignatureScreen.routeName);
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
    return Theme(
      data: Themings.darkTheme.copyWith(primaryColor: createMaterialColor(Colors.white)),
      child: Auth(hasManyTextFields: true, children: [
        Text(
          "Compléter votre compte",
          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
        ),
        Text(
          "Entrez vos information pour compléter votre compte",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 36,
        ),
        CustomEditText(
          controller: telController,
          label: "Numéro de téléphone",
          isTel: true,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16),
        CustomEditText(
          controller: mailController,
          label: "E-mail",
          isEmail: true,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16),
        CustomEditText(
          controller: pwdController,
          label: "Mot de passe",
          isObscure: true,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16),
        CustomEditText(
          controller: pwdConfirmController,
          label: "Confirmer mot de passe",
          isObscure: true,
          textInputAction: TextInputAction.done,
        ),],
        floatingChild: ActionButton(text: "Suivant", onPressed: onPressed),
      ),
    );
  }
}
