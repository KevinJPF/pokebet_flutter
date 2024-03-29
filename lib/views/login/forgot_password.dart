import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';
import 'package:pokebet/widgets/custom_button.dart';
import 'package:pokebet/widgets/custom_text_field.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/meowth_logo.dart';
import 'package:pokebet/widgets/custom_popup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.pokebetColors.backgroundColor,
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
                                top: setHeight(32), bottom: setHeight(16)),
                            child: MeowthLogo(
                              onTap: () {
                                setState(() {});
                              },
                            ),
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
