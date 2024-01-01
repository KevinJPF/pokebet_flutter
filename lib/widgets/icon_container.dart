// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final String mainText;
  final String secondaryText;
  final String? svgName;
  final String? imageName;
  final int? spriteIndex;
  final bool showRightIcon;
  final VoidCallback? onClick;

  const IconContainer({
    super.key,
    required this.icon,
    required this.mainText,
    this.secondaryText = '',
    this.svgName,
    this.showRightIcon = false,
    this.imageName,
    this.spriteIndex, this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick ?? () {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: setHeight(50),
              margin: EdgeInsets.symmetric(horizontal: setWidth(32)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: setWidth(70),
                          decoration: BoxDecoration(
                            color: Global.iconContainerIconBackColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  8.0), // Raio do canto superior esquerdo
                              bottomLeft: Radius.circular(
                                  8.0), // Raio do canto inferior esquerdo
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(setWidth(spriteIndex == null ? 5 : 0)),
                            child: Builder(
                              builder: (context) {
                                if (svgName != null) {
                                  return SvgPicture.asset(
                                    'assets/svgs/$svgName.svg',
                                    fit: BoxFit.contain,
                                  );
                                } else if (imageName != null) {
                                  return Image.asset(
                                    'assets/imgs/icons/$imageName.jpg',
                                    fit: BoxFit.contain,
                                  );
                                } else if (spriteIndex != null) {
                                  return Container(
                                    // color: Colors.pink,
                                    child: Image.network(
                                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$spriteIndex.png',
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                } else {
                                  return Icon(
                                    icon,
                                    size: setHeight(40),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleTextWhiteBackground(mainText),
                        Visibility(
                          visible: secondaryText != '',
                          child: SimpleTextWhiteBackground(secondaryText),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: showRightIcon,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
                      // color: Colors.pink,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_notifications_outlined,
                            color: Global.iconContainerIconBackColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
