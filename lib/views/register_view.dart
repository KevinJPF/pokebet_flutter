import 'package:flutter/material.dart';
import 'package:pokebet_login/components/background.dart';
import 'package:pokebet_login/components/custom_button.dart';
import 'package:pokebet_login/components/custom_text_field.dart';
import 'package:pokebet_login/components/highlight_link.dart';
import 'package:pokebet_login/components/meowth_logo.dart';
import 'package:pokebet_login/components/popup_message.dart';

import '../models/userdata.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final controllerUserName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();

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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controllerText: controllerUserName,
                          hintText: 'Usuário',
                          isPassword: false,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controllerText: controllerEmail,
                          hintText: 'Email',
                          isPassword: false,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controllerText: controllerPassword,
                          hintText: 'Senha',
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controllerText: controllerConfirmPassword,
                          hintText: 'Confirmar Senha',
                          isPassword: true,
                        ),
                        const SizedBox(height: 26),
                        CustomButton(
                          onPressed: () {
                            final username = controllerUserName.text;
                            final password = controllerPassword.text;
                            final confirmPassword =
                                controllerConfirmPassword.text;
                            final email = controllerEmail.text;

                            if (username.isNotEmpty &&
                                email.isNotEmpty &&
                                password.isNotEmpty &&
                                confirmPassword.isNotEmpty) {
                              if (password == confirmPassword) {
                                final userData =
                                    UserData(username, password, email);

                                Navigator.of(context).pop(userData);
                              } else {
                                mostrarPopUpErro(context,
                                    "As senhas digitadas não correspondem.");
                              }
                            } else {
                              mostrarPopUpErro(context,
                                  "Todos os campos devem ser preenchidos para cadastrar um usuário.");
                            }
                          },
                          buttonText: 'Cadastrar',
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: HighlightLinkWithText(
                              normalText: "Já tem uma conta?",
                              linkText: "Login",
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
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
