import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/pokemon_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final String mainText;
  final String secondaryText;
  final String? svgName;
  final String? iconPNGName;
  final String? assetImageName;
  final String? assetRightIconName;
  final String? rightText;
  final String? rightFirstType;
  final String? rightSecondType;
  final String? spriteUrl;
  final bool showRightIcon;
  final bool isShiny;
  final VoidCallback? onClick;

  const IconContainer({
    super.key,
    required this.icon,
    required this.mainText,
    this.isShiny = false,
    this.secondaryText = '',
    this.svgName,
    this.showRightIcon = false,
    this.iconPNGName,
    this.assetImageName,
    this.assetRightIconName,
    this.spriteUrl,
    this.onClick,
    this.rightText,
    this.rightFirstType,
    this.rightSecondType,
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
                            color:
                                Global.pokebetColors.iconContainerIconBackColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  8.0), // Raio do canto superior esquerdo
                              bottomLeft: Radius.circular(
                                  8.0), // Raio do canto inferior esquerdo
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: setWidth(spriteUrl == null ? 5 : 0),
                              horizontal: setWidth(spriteUrl == null
                                  ? assetImageName == null
                                      ? 7
                                      : 17
                                  : 0),
                            ),
                            child: Builder(
                              builder: (context) {
                                if (svgName != null) {
                                  return SvgPicture.asset(
                                    'assets/svgs/$svgName.svg',
                                    fit: BoxFit.contain,
                                  );
                                } else if (iconPNGName != null) {
                                  return Image.asset(
                                    'assets/imgs/icons/$iconPNGName.png',
                                    fit: BoxFit.contain,
                                  );
                                } else if (assetImageName != null) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.8),
                                          spreadRadius: 0,
                                          blurRadius: 6,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/imgs/capture_places/$assetImageName.jpg',
                                        fit: BoxFit.cover,
                                        // color: Colors.black,
                                      ),
                                    ),
                                  );
                                } else if (spriteUrl != null) {
                                  return Image.network(
                                    spriteUrl!,
                                    fit: BoxFit.contain,
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
                    padding: EdgeInsets.only(left: setWidth(16)),
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleTextWhiteBackground(
                            mainText.length > 20
                                ? '${mainText.substring(0, 19)}...'
                                : mainText),
                        Visibility(
                          visible: secondaryText != '',
                          child: SimpleTextWhiteBackground(secondaryText),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
                    // color: Colors.pink,
                    child: Row(
                      children: [
                        if (rightText != null) ...[
                          SimpleTextWhiteBackground(rightText!),
                          SizedBox(width: setWidth(8)),
                        ],
                        if (showRightIcon || assetRightIconName != null) ...[
                          if (assetRightIconName == null)
                            Icon(
                              Icons.circle_notifications_outlined,
                              color: Global
                                  .pokebetColors.iconContainerIconBackColor,
                            )
                          else
                            Image.asset('assets/imgs/icons/${assetRightIconName!}.png', width: setWidth(25),),
                        ],
                        if (rightFirstType != null)
                          Stack(
                            children: [
                              if (rightSecondType != null)
                                TypeIcon(rightSecondType!,
                                    showTypeName: false, iconSize: 40),
                              ClipPath(
                                clipper: rightSecondType != null
                                    ? DiagonalClipper()
                                    : null,
                                child: TypeIcon(rightFirstType!,
                                    showTypeName: false, iconSize: 40),
                              ),
                            ],
                          ),
                      ],
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

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
