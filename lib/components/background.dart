import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final bool hasLogo;
  const Background({super.key, required this.hasLogo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(23, 0, 52, 1),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                top: hasLogo ? 150 : 50, bottom: 10, right: 15, left: 15),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.3),
              borderRadius:
                  BorderRadius.circular(30), // Valor do border radius.
            ),
          ),
        ),
      ],
    );
  }
}
