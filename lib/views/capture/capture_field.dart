// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/views/capture/search_pokemon.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/pokemon_type.dart';
import 'package:PokeBet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';

class CaptureField extends StatefulWidget {
  final String fieldName;
  final String fieldDescription;
  final String fieldImageName;
  final List<String> commonTypes;
  final List<String> rareTypes;
  const CaptureField({
    super.key,
    required this.fieldName,
    required this.fieldDescription,
    required this.fieldImageName,
    required this.commonTypes,
    required this.rareTypes,
  });

  @override
  State<CaptureField> createState() => _CaptureFieldState();
}

class _CaptureFieldState extends State<CaptureField> {
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
                        TopBar(showBackButton: true, pageTitle: ''),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        top: setHeight(80),
                        bottom: setHeight(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: setWidth(32)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.asset(
                                      'assets/imgs/capture_places/${widget.fieldImageName}.jpg',
                                      fit: BoxFit.cover,
                                      height: setHeight(150),
                                      // width: setHeight(300),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: setHeight(16)),
                          SimpleText(
                            widget.fieldName,
                            fontSize: 32,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: setWidth(32)),
                            child: SimpleText(widget.fieldDescription),
                          ),
                          Spacer(),
                          SimpleText(
                            'Tipos mais comuns:',
                          ),
                          SizedBox(height: setHeight(16)),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidth(32)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.commonTypes.map((String type) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: setWidth(4)),
                                    child: TypeIcon(type, showTypeName: false),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: setHeight(16)),
                          SimpleText(
                            'Tipos mais raros:',
                          ),
                          SizedBox(height: setHeight(16)),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidth(32)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.rareTypes.map((String type) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: setWidth(4)),
                                    child: TypeIcon(type, showTypeName: false),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: setHeight(16)),
                          CustomButton(
                            buttonText: 'Procurar Pokemon',
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPokemon(
                                    filtrarResultados: true,
                                    shinyChances: 100,
                                    canBeLegendary: false,
                                    maxStats: 200,
                                    commonTypes: widget.commonTypes,
                                    rareTypes: widget.rareTypes,
                                    evolutionChainLimit: 0,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
