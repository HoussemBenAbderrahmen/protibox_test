
import 'package:flutter/material.dart';
import 'package:proti_box/colors.dart';

class CustomEditText extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isObscure;
  final bool isEmail;
  final bool isTel;
  final TextInputAction textInputAction;

  const CustomEditText(
      {Key? key,
      required this.controller,
      required this.label,
      this.isObscure = false,
      this.isEmail = false,
      this.isTel = false,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).backgroundColor != Colors.white;
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {setState(() {
          isFocused = focus;
        });},
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Theme.of(context).primaryColorDark : Colors.white,
            border: isDark ? null : (isFocused ? Border.all(color: Colors.black) : Border.all(color: AppColors.lightGrey)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              style: TextStyle(
                  color: isDark ? Colors.white : AppColors.grey,
                  fontWeight: FontWeight.bold),
              controller: widget.controller,
              obscureText: widget.isObscure,
              enableSuggestions: !widget.isObscure,
              autocorrect: !widget.isObscure,
              keyboardType: (() {
                if (widget.isEmail) {
                  return TextInputType.emailAddress;
                } else if (widget.isTel) {
                  return TextInputType.number;
                } else {
                  return TextInputType.text;
                }
              }()),
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                border: InputBorder.none,
                // border: OutlineInputBorder(),
                labelStyle: isDark
                    ? Theme.of(context).textTheme.labelMedium
                    : Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppColors.grey),
                labelText: widget.label,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
