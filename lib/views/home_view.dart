import 'package:flutter/material.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/custom_text_field.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/meowth_logo.dart';
import 'package:PokeBet/views/login/first_pokemon.dart';

import '../widgets/custom_popup.dart';
import 'login/register_view.dart';
import '../models/user_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final userList = <UserData>[];
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Background(hasLogo: true),
                    Column(
                      children: [
                        CustomTextField(
                          controllerText: controllerUserName,
                          hintText: 'Usuário',
                          isPassword: false,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controllerText: controllerPassword,
                          hintText: 'Usuário',
                          isPassword: true,
                        ),
                        const SizedBox(height: 26),
                        CustomButton(
                          onPressed: () {
                            if (userList
                                .where((element) =>
                                    element.username ==
                                        controllerUserName.text &&
                                    element.password == controllerPassword.text)
                                .isNotEmpty) {
                              final userData = userList
                                  .where((element) =>
                                      element.username ==
                                          controllerUserName.text &&
                                      element.password ==
                                          controllerPassword.text)
                                  .first;
                              CustomPopup(
                                popupTitle: 'Sucesso',
                                popupMessage:
                                    'O login foi realizado com sucesso.\nUsuário: ${userData.username}\nEmail: ${userData.email}',
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const FirstPokemon(),
                                ),
                              );
                            } else {
                              CustomPopup(
                                popupTitle: 'Erro',
                                popupMessage:
                                    'O usuário e/ou a senha digitados estão invalidos.',
                              );
                            }
                          },
                          buttonText: "Entrar",
                        ),
                        const SizedBox(height: 26),
                        HighlightLink(
                          "Esqueci Minha Senha",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FirstPokemon(),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(bottom: 30),
                        //     // child: SimpleText(
                        //     //   text: "Não tem uma conta?",
                        //     //   linkText: "Cadastre-se",
                        //     //   onTap: () async {
                        //     //     final result = await Navigator.of(context).push(
                        //     //       MaterialPageRoute(
                        //     //         builder: (context) => const RegisterView(),
                        //     //       ),
                        //     //     );

                        //     //     if (result != null && result is UserData) {
                        //     //       userList.add(result);
                        //     //     }
                        //     //   },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
