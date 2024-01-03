// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/widgets/menu_bar.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});

  @override
  State<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.pokebetColors.backgroundColor,
      body: SafeArea(
        child: Container(
          height: availableHeight,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Background(hasLogo: false),
                    Column(
                      children: [
                        TopBar(showBackButton: false, pageTitle: 'Torneios'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 80, bottom: 40),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
