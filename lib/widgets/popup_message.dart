import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';
import 'package:pokebet_login/widgets/custom_texts.dart';

void customPopup(BuildContext context, String tituloPopup, String mensagemPopup) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SimpleText(tituloPopup),
        content: SimpleText(mensagemPopup),
        backgroundColor: Global.backgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar',style: TextStyle(color: Global.highlightTextColor)),
          ),
        ],
      );
    },
  );
}
