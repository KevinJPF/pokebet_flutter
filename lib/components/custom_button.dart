import 'package:flutter/material.dart';

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
        minimumSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width - 80, 50)),
        backgroundColor: const MaterialStatePropertyAll(
          Color.fromRGBO(57, 0, 128, 1),
        ),
        foregroundColor: const MaterialStatePropertyAll(
          Color.fromRGBO(255, 255, 112, 1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Raio das bordas.
          ),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
