// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controllerText;
  final String hintText;
  final bool isPassword;

  CustomTextField({
    super.key,
    required this.controllerText,
    required this.hintText,
    required this.isPassword,
  });

  ValueNotifier<bool> _hidePassword = ValueNotifier(true);

  showHidePassword() {
    _hidePassword.value = !_hidePassword.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hidePassword,
      builder: (context, value, child) {
        return Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white, // Cor de fundo
            borderRadius: BorderRadius.circular(8), // Border radius
          ),
          child: Stack(
            children: [
              TextField(
                controller: controllerText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(25, 25, 25, 0.3)),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: setFontSize(16),
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (text) {
                  // Remove espaços em branco
                  if (!isPassword) {
                    final textWithoutSpaces = text.replaceAll(' ', '');
                    if (text != textWithoutSpaces) {
                      controllerText.value = TextEditingValue(
                        text: textWithoutSpaces,
                        selection: TextSelection.collapsed(
                            offset: textWithoutSpaces.length),
                      );
                    }
                  }
                },
                obscureText: isPassword ? _hidePassword.value : false,
              ),
              Visibility(
                visible: isPassword,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(right: setWidth(16)),
                        color: Colors.transparent,
                        alignment: Alignment.centerRight,
                        child:
                            // Usando texto
                            HighlightLink(
                          hidePasswordText: true,
                          _hidePassword.value ? 'Mostrar' : 'Ocultar',
                          onTap: () {
                            showHidePassword();
                          },
                        ),
                        // Usando Icone
                        // GestureDetector(
                        //   child: Icon(
                        //     _hidePassword.value
                        //         ? Icons.visibility_off_rounded
                        //         : Icons.visibility_rounded,
                        //     color: Global.showPasswordColor,
                        //   ),
                        //   onTap: () {
                        //     showHidePassword();
                        //   },
                        // )
                      ),
                      onTap: () {
                        showHidePassword();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
