import 'package:coffee_ui/utils/constants.dart';
import 'package:flutter/material.dart';

class SizeTextButton extends StatelessWidget {
  const SizeTextButton({
    Key? key,
    required this.onPressed,
    required this.word,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String word;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: buttonShape,
        fixedSize: buttonSize,
        backgroundColor: buttonColor,
      ),
      child: Text(
        word,
        style: themeData.textTheme.headline4?.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
