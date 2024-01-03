// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/views/login/forgot_password.dart';
import 'package:PokeBet/views/login/first_pokemon.dart';
import 'package:PokeBet/views/login/register_view.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_text_field.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';
import 'package:PokeBet/widgets/custom_popup.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

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
          child: SizedBox(
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
                            child: MeowthLogo(
                              onTap: () {
                                setState(() {});
                              },
                            ),
                          ),
                          CustomTextField(
                            controllerText: _controllerUser,
                            hintText: 'Usuário',
                            isPassword: false,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            controllerText: _controllerPassword,
                            hintText: 'Senha',
                            isPassword: true,
                          ),
                          SizedBox(height: 32),
                          CustomButton(
                            buttonText: 'Entrar',
                            onPressed: () async {
                              if (_controllerUser.text != '') {
                                Global.userName = _controllerUser.text;
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const FirstPokemon(),
                                  ),
                                );
                                setState(() {});
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomPopup(
                                    popupTitle: 'Erro',
                                    popupMessage:
                                        'Verifique se digitou os dados corretamente e tente novamente.',
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: setHeight(16)),
                          HighlightLink('Esqueci minha senha', onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                            setState(() {});
                          }),
                          Spacer(),
                          Column(
                            children: [
                              SimpleText(
                                'Não tem uma conta?',
                              ),
                              HighlightLink('Cadastre-se', onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
                                  ),
                                );
                                setState(() {});
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
