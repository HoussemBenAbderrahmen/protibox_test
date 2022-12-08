import 'package:flutter/material.dart';
import 'package:proti_box/colors.dart';

class ActionButton extends StatelessWidget {
  final String text;

  final Function? onPressed;
  final bool isWidthInfinite;

  const ActionButton({Key? key, required this.text, required this.onPressed, this.isWidthInfinite = true})
      : super(key: key);

  _nothing() {}

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).backgroundColor != Colors.white;
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 52,
        width: isWidthInfinite ? double.infinity : 100,
        child: InkWell(
          onTap: onPressed ?? _nothing(),
          child: Card(
            elevation: onPressed != null ? 8 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: !isDark ? LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark
                ]) : null,
                color: isDark ? Colors.white : null,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: onPressed != null
                          ? isDark
                              ? Theme.of(context).primaryColorDark
                              : Colors.white
                          : isDark
                              ? AppColors.grey
                              : Color(0xFFD9D9D9),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
