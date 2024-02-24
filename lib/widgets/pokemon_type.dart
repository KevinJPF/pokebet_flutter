import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeIcon extends StatelessWidget {
  final String type;
  final double iconSize;
  final bool showTypeName;
  const TypeIcon(this.type,
      {super.key, this.iconSize = 50, this.showTypeName = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showTypeName)
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: setWidth(28), top: setHeight(7.5)),
            // padding: EdgeInsets.all(setWidth(7.5)),
            width: setWidth(110),
            height: setHeight(35),
            decoration: BoxDecoration(
              color: Types.colors[type.toLowerCase()], // Cor de fundo
              borderRadius: BorderRadius.circular(200), // Border radius
            ),
            child: SimpleText(
              type,
              fontColor: Global.pokebetColors.whiteColor,
            ),
          ),
        Container(
          padding: EdgeInsets.all(setWidth(7.5)),
          width: setWidth(iconSize),
          height: setWidth(iconSize),
          decoration: BoxDecoration(
            color: Types.colors[type.toLowerCase()], // Cor de fundo
            borderRadius: BorderRadius.circular(200), // Border radius
          ),
          child: SvgPicture.asset(
            'assets/svgs/types/${type.toLowerCase()}.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
