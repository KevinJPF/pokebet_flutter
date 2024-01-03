import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PokeBet/global.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const CustomButton(
      {super.key, required this.buttonText, required this.onPressed});

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
      child: Text(
        buttonText,
        style: TextStyle(
            fontSize: setFontSize(16),
            fontFamily: 'Abel',
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
