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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                          CustomTextField(
                            controllerText: _controllerUser,
                            hintText: 'Usuário',
                            isPassword: false,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            controllerText: _controllerEmail,
                            hintText: 'Email',
                            isPassword: false,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            controllerText: _controllerPassword,
                            hintText: 'Senha',
                            isPassword: true,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            controllerText: _controllerConfirmPassword,
                            hintText: 'Confirmar Senha',
                            isPassword: true,
                          ),
                          Spacer(),
                          CustomButton(
                            buttonText: 'Cadastrar',
                            onPressed: () {
                              CustomPopup(
                                popupTitle: 'Sucesso',
                                popupMessage:
                                    'Usuário ${_controllerUser.text} cadastrado com sucesso!',
                              );
                            },
                          ),
                          SizedBox(height: setHeight(16)),
                          Column(
                            children: [
                              SimpleText(
                                'Já tem uma conta?',
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
