import 'package:flutter/material.dart';

class CoinFlipAnimation extends StatefulWidget {
  @override
  _CoinFlipAnimationState createState() => _CoinFlipAnimationState();
}

class _CoinFlipAnimationState extends State<CoinFlipAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }