import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/custom_texts.dart';

class CustomPopup extends StatelessWidget {
  final String popupTitle;
  final String popupMessage;
  final String? firstButtonText;
  final String? secondButtonText;
  final VoidCallback? onPressedFirstButton;
  final VoidCallback? onPressedSecondButton;

  const CustomPopup({
    super.key,
    required this.popupTitle,
    required this.popupMessage,
    this.firstButtonText,
    this.secondButtonText,
    this.onPressedFirstButton,
    this.onPressedSecondButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SimpleText(popupTitle),
      content: SimpleText(popupMessage),
      backgroundColor: Global.pokebetColors.backgroundColor,
      actions: [
        TextButton(
          onPressed: onPressedFirstButton ?? () {
            Navigator.of(context).pop();
          },
          child: Text(firstButtonText ?? 'Fechar',
              style: TextStyle(color: Global.pokebetColors.highlightColor)),
        ),
        if (secondButtonText != null) ...[
          TextButton(
            onPressed: onPressedSecondButton ?? () {
              Navigator.of(context).pop();
            },
            child: Text(secondButtonText ?? 'Confirmar',
                style: TextStyle(color: Global.pokebetColors.highlightColor)),
          ),
        ],
      ],
    );
  }
}
