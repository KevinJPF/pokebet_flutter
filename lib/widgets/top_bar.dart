import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';

class TopBar extends StatelessWidget {
  final bool showBackButton;
  final String pageTitle;
  const TopBar({super.key, this.showBackButton = true, this.pageTitle = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                top: setHeight(16), left: setWidth(16), right: setWidth(16)),
            padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
            height: setHeight(64),
            // color: Colors.pink,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                    visible: showBackButton,
                    child: GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Icon(Icons.arrow_back_rounded)),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Center(
                    child: SimpleText(
                  pageTitle,
                  fontSize: 28,
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
