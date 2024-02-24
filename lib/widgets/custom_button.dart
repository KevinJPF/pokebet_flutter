import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final SvgPicture? buttonImage;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonImage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: setHeight(16)),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(MediaQuery.of(context).size.width - 80, 50),
        ),
        backgroundColor: MaterialStatePropertyAll(
          Global.pokebetColors.buttonColor,
        ),
        foregroundColor: MaterialStatePropertyAll(
          Global.pokebetColors.buttonTextColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Raio das bordas.
          ),
        ),
      ),
      child: (buttonImage == null) ? Text(
        buttonText,
        style: TextStyle(
            fontSize: setFontSize(16),
            fontFamily: 'Abel',
            fontWeight: FontWeight.w600),
      ) : buttonImage,
    );
  }
}
