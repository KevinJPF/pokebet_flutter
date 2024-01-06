// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously

import 'package:PokeBet/database/db_connection.dart';
import 'package:PokeBet/models/database_models.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
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
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

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
                            onPressed: () async {
                              final username = _controllerUser.text;
                              final password = _controllerPassword.text;
                              final confirmPassword =
                                  _controllerConfirmPassword.text;
                              final email = _controllerEmail.text;

                              if (username.isNotEmpty &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty &&
                                  confirmPassword.isNotEmpty) {
                                if (password == confirmPassword) {
                                  if ((await DatabaseConnection()
                                              .selectDatabaseData(
                                        databaseTable: 'users',
                                        where: 'name = ?',
                                        whereArgs: [
                                          _controllerUser.text,
                                        ],
                                      ))
                                          .firstOrNull ==
                                      null) {
                                    UserData addUser = UserData(
                                      name: username,
                                      password: password,
                                      email: email,
                                      money: 0,
                                      level: 1,
                                      experience: 0,
                                      capturedPokemons: 1,
                                      pokebetsParticipated: 0,
                                      pokebetsWon: 0,
                                      tournamentsParticipated: 0,
                                      tournamentsWon: 0,
                                      firstLogin: 1,
                                      rememberMe: 0,
                                    );
                                    var userMap = addUser.toMap();

                                    try {
                                      DatabaseConnection().insertDatabaseData(
                                          object: userMap,
                                          databaseTable: 'users');
                                    } catch (exception) {
                                      throw ('Erro ao inserir dados no banco: $exception');
                                    }

                                    await showDialog(
                                      context: context,
                                      builder: (context) => CustomPopup(
                                        popupTitle: 'Sucesso',
                                        popupMessage:
                                            'Usuário ${_controllerUser.text} cadastrado com sucesso!',
                                        firstButtonText: 'Voltar',
                                        onPressedFirstButton: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomPopup(
                                        popupTitle: 'Atenção',
                                        popupMessage:
                                            'Já existe um usuário com este nome.',
                                      ),
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomPopup(
                                      popupTitle: 'Atenção',
                                      popupMessage:
                                          'As senhas digitadas não correspondem.',
                                    ),
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomPopup(
                                    popupTitle: 'Atenção',
                                    popupMessage:
                                        'Todos os campos devem ser preenchidos para cadastrar um usuário.',
                                  ),
                                );
                              }
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
