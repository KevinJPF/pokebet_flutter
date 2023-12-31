// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/views/login_view.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_text_field.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';
import 'package:PokeBet/widgets/custom_popup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: availableHeight,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Background(hasLogo: true),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: setHeight(60), bottom: setHeight(16)),
                            child: MeowthLogo(),
                          ),
                          SimpleText(
                            'Enviar email de recuperação de senha',
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            controllerText: _controllerEmail,
                            hintText: 'Email',
                            isPassword: false,
                          ),
                          Spacer(),
                          CustomButton(
                            buttonText: 'Confirmar',
                            onPressed: () {
                              var titlePopup = '';
                              var textPopup = '';
                              if (_controllerEmail.text != '') {
                                titlePopup = 'Sucesso';
                                textPopup =
                                    'Um email foi enviado para você, verifique o passo a passo para a recuperação da sua senha.';
                              } else {
                                titlePopup = 'Aviso';
                                textPopup =
                                    'Você precisa digitar um email válido para que a recuperação de email possa ser concluída.';
                              }
                              showDialog(
                                context: context,
                                builder: (context) => CustomPopup(
                                  popupTitle: titlePopup,
                                  popupMessage: textPopup,
                                  onPressedFirstButton: () {
                                    if (_controllerEmail.text != '') {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: setHeight(16)),
                          Column(
                            children: [
                              SimpleText(
                                'Lembra da senha?',
                              ),
                              HighlightLink('Entrar', onTap: () {
                                Navigator.of(context).pop();
                              }),
                            ],
                          ),
                          SizedBox(height: setHeight(32))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
