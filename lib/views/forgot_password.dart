// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';
import 'package:pokebet_login/views/login_view.dart';
import 'package:pokebet_login/widgets/background.dart';
import 'package:pokebet_login/widgets/custom_button.dart';
import 'package:pokebet_login/widgets/custom_text_field.dart';
import 'package:pokebet_login/widgets/custom_texts.dart';
import 'package:pokebet_login/widgets/meowth_logo.dart';
import 'package:pokebet_login/widgets/popup_message.dart';

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
                              customPopup(context, 'Sucesso',
                                  'Um email foi enviado para você, verifique o passo a passo para a recuperação da sua senha.');
                            },
                          ),
                          SizedBox(height: setHeight(16)),
                          Column(
                            children: [
                              SimpleText(
                                'Lembra da senha?',
                              ),
                              HighlightLink('Entrar', onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
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
