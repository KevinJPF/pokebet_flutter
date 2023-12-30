import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';

class TopBar extends StatelessWidget {
  final bool showBackButton;
  const TopBar({super.key, this.showBackButton = true});

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
            padding: EdgeInsets.symmetric(
                vertical: setHeight(16), horizontal: setWidth(16)),
            height: setHeight(64),
            // color: Colors.pink,
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
        ),
      ],
    );
  }
}
