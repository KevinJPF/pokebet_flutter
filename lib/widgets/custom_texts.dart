import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';

class SimpleText extends StatelessWidget {
  final String text;
  const SimpleText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Global.simpleTextColor,
        fontSize: setFontSize(16),
        fontFamily: 'Abel',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class HighlightLink extends StatelessWidget {
  final String linkText;
  final VoidCallback onTap;
  const HighlightLink(
    this.linkText, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        linkText,
        style: TextStyle(
            color: Global.highlightTextColor,
            fontSize: setFontSize(16),
            fontFamily: 'Abel',
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
