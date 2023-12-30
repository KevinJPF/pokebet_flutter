// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:pokebet_login/global.dart';
import 'package:pokebet_login/views/forgot_password.dart';
import 'package:pokebet_login/views/pokemonEgg_view.dart';
import 'package:pokebet_login/views/register_view.dart';
import 'package:pokebet_login/widgets/background.dart';
import 'package:pokebet_login/widgets/custom_button.dart';
import 'package:pokebet_login/widgets/custom_text_field.dart';
import 'package:pokebet_login/widgets/custom_texts.dart';
import 'package:pokebet_login/widgets/meowth_logo.dart';
import 'package:pokebet_login/widgets/popup_message.dart';

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
      backgroundColor: Global.backgroundColor,
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
                            child: MeowthLogo(),
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
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const PokemonEgg(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: setHeight(16)),
                          HighlightLink('Esqueci minha senha', onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          }),
                          Spacer(),
                          Column(
                            children: [
                              SimpleText(
                                'Não tem uma conta?',
                              ),
                              HighlightLink('Cadastre-se', onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
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
