import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';

class SimpleText extends StatelessWidget {
  final Color? fontColor;
  final double? fontSize;
  final String text;
  const SimpleText(
    this.text, {
    super.key,
    this.fontColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor ?? Global.pokebetColors.simpleTextColor,
        fontSize: setFontSize(fontSize ?? 16),
        fontFamily: 'Abel',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class SimpleTextWhiteBackground extends StatelessWidget {
  final String text;
  const SimpleTextWhiteBackground(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Global.pokebetColors.simpleTextWhiteBackgroundColor,
        fontSize: setFontSize(16),
        fontFamily: 'Abel',
        fontWeight: FontWeight.w600,
      ),
      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
    );
  }
}

class HighlightLink extends StatelessWidget {
  final String linkText;
  final VoidCallback onTap;
  final bool hidePasswordText;
  const HighlightLink(
    this.linkText, {
    super.key,
    required this.onTap,
    this.hidePasswordText = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        linkText,
        style: TextStyle(
          color: hidePasswordText
              ? Global.pokebetColors.showPasswordColor
              : Global.pokebetColors.highlightColor,
          fontSize: setFontSize(16),
          fontFamily: 'Abel',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
