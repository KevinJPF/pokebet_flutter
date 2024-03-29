import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';

class MeowthLogo extends StatefulWidget {
  final VoidCallback onTap;
  const MeowthLogo({super.key, required this.onTap});

  @override
  State<MeowthLogo> createState() => _MeowthLogoState();
}

class _MeowthLogoState extends State<MeowthLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    Future.delayed(Duration(milliseconds: 250), () {
      Global.toggleTheme();
      widget.onTap();
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleFlip,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final rotateValue =
                  Tween(begin: pi, end: 0.0).animate(_controller);

              return Transform(
                transform: Matrix4.rotationY(rotateValue.value),
                alignment: Alignment.center,
                child: Container(
                  // color: Colors.white,
                  height: setHeight(160),
                  width: setWidth(180),
                  child: Image.asset(
                    'assets/imgs/meowth_${Global.appOptions.theme}.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          "Pokebet",
          style: TextStyle(
            color: Global.pokebetColors.highlightColor,
            fontSize: 24,
            fontFamily: 'Chakra',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
