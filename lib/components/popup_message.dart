import 'package:flutter/material.dart';

void mostrarPopUpErro(BuildContext context, String msgDeErro) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: Text(msgDeErro),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}

void mostrarPopupSucesso(BuildContext context, String msgDeSucesso) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sucesso'),
        content: Text(msgDeSucesso),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}
