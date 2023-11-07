import 'package:flutter/material.dart';
import 'package:pokebet_login/components/background.dart';
import 'package:pokebet_login/components/custom_button.dart';
import 'package:pokebet_login/components/custom_text_field.dart';
import 'package:pokebet_login/components/highlight_link.dart';
import 'package:pokebet_login/components/meowth_logo.dart';
import 'package:pokebet_login/views/pokemonEgg_view.dart';

import '../components/popup_message.dart';
import 'register_view.dart';
import '../models/userdata.dart';

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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Background(hasLogo: true),
              Column(
                children: [
                  const MeowthLogo(),
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
                              element.username == controllerUserName.text &&
                              element.password == controllerPassword.text)
                          .isNotEmpty) {
                        final userData = userList
                            .where((element) =>
                                element.username == controllerUserName.text &&
                                element.password == controllerPassword.text)
                            .first;
                        mostrarPopupSucesso(context,
                            'O login foi realizado com sucesso.\nUsuário: ${userData.username}\nEmail: ${userData.email}');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PokemonEgg(),
                          ),
                        );
                      } else {
                        mostrarPopUpErro(context,
                            'O usuário e/ou a senha digitados estão invalidos.');
                      }
                    },
                    buttonText: "Entrar",
                  ),
                  const SizedBox(height: 26),
                  HighlightLink(
                    linkText: "Esqueci Minha Senha",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PokemonEgg(),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: HighlightLinkWithText(
                        normalText: "Não tem uma conta?",
                        linkText: "Cadastre-se",
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );

                          if (result != null && result is UserData) {
                            userList.add(result);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
