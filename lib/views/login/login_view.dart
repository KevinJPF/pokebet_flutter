// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously

import 'package:PokeBet/database/db_connection.dart';
import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/views/profile/player_profile.dart';
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
  Widget? initialScreen;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    DatabaseConnection().closeDb();
    super.dispose();
  }

  limpaCampos() {
    _controllerUser.text = '';
    _controllerPassword.text = '';
  }

  Future<bool> loginUser({String? userName, String? password}) async {
    if (Global.userData == null) {
      bool loginSuccesfull = await Global.loadInitialData(
        login: userName != null,
        userName: userName,
        userPassword: password,
      );

      if (loginSuccesfull) {
        if (Global.userData!.firstLogin == 1) {
          initialScreen = FirstPokemon();
        } else {
          Global.userData!.rememberMe = 1;
          UserData.UpdateUserDatabase();
          initialScreen = PlayerProfile();
        }
        Global.isLogged.value = true;
        Global.canPopLogout = false;
        limpaCampos();
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => initialScreen!,
          ),
        );
        setState(() {});
        return true;
      } else {
        if (userName != null && password != null) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              popupTitle: 'Atenção',
              popupMessage: 'O usuário e/ou a senha digitados estão invalidos.',
            ),
          );
        }
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return ValueListenableBuilder<bool>(
      valueListenable: Global.isLogged,
      builder: (context, value, child) => Scaffold(
        backgroundColor: Global.pokebetColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: availableHeight,
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: loginUser(),
                      builder: (context, value) {
                        if (value.hasData) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Background(hasLogo: true),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: setHeight(60),
                                        bottom: setHeight(16)),
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
                                      Global.clearGlobal();
                                      await loginUser(
                                          userName: _controllerUser.text,
                                          password: _controllerPassword.text);
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: setHeight(16)),
                                  HighlightLink('Esqueci minha senha',
                                      onTap: () async {
                                    limpaCampos();
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword(),
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
                                      HighlightLink('Cadastre-se',
                                          onTap: () async {
                                        limpaCampos();
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterView(),
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
                          );
                        } else {
                          return Background(hasLogo: false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
