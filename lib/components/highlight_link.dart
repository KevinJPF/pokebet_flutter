import 'package:flutter/material.dart';

class HighlightLink extends StatelessWidget {
  final String linkText;
  final VoidCallback onTap;
  const HighlightLink({
    super.key,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        linkText,
        style: const TextStyle(
          color: Color.fromRGBO(255, 255, 112, 1),
          fontSize: 16,
          fontFamily: 'Arial',
        ),
      ),
    );
  }
}

class HighlightLinkWithText extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onTap;
  const HighlightLinkWithText({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          normalText,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
            fontFamily: 'Arial',
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: const TextStyle(
              color: Color.fromRGBO(255, 255, 112, 1),
              fontSize: 16,
              fontFamily: 'Arial',
            ),
          ),
        ),
      ],
    );
  }
}
