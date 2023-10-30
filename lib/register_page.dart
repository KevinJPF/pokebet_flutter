import 'package:flutter/material.dart';

import 'userdata.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerUserName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(23, 0, 52, 1),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150, bottom: 10),
              height: MediaQuery.of(context).size.height - 80,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.3),
                borderRadius:
                    BorderRadius.circular(30), // Valor do border radius.
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: 214,
                    width: 164,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        'assets/imgs/meowth.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: const Text(
                      "Pokebet",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 112, 1),
                        fontSize: 24,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 260),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: TextField(
                      controller: controllerUserName,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16),
                        border: InputBorder.none,
                        hintText: 'Usuário',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(25, 25, 25, 0.3)),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (text) {
                        // Remove espaços em branco
                        final textWithoutSpaces = text.replaceAll(' ', '');
                        if (text != textWithoutSpaces) {
                          controllerUserName.value = TextEditingValue(
                            text: textWithoutSpaces,
                            selection: TextSelection.collapsed(
                                offset: textWithoutSpaces.length),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: TextField(
                      controller: controllerEmail,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16),
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(25, 25, 25, 0.3)),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (text) {
                        // Remove espaços em branco
                        final textWithoutSpaces = text.replaceAll(' ', '');
                        if (text != textWithoutSpaces) {
                          controllerEmail.value = TextEditingValue(
                            text: textWithoutSpaces,
                            selection: TextSelection.collapsed(
                                offset: textWithoutSpaces.length),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: TextField(
                      controller: controllerPassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                        hintText: 'Senha',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(25, 25, 25, 0.3)),
                      ),
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 26),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: TextField(
                      controller: controllerConfirmPassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                        hintText: 'Confirmar Senha',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(25, 25, 25, 0.3)),
                      ),
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final username = controllerUserName.text;
                      final password = controllerPassword.text;
                      final confirmPassword = controllerConfirmPassword.text;
                      final email = controllerEmail.text;

                      if (username.isNotEmpty &&
                          email.isNotEmpty &&
                          password.isNotEmpty &&
                          confirmPassword.isNotEmpty) {
                        if (password == confirmPassword) {
                          final userData = UserData(username, password, email);

                          Navigator.of(context).pop(userData);
                        } else {
                          _mostrarPopUpErro(
                              context, "As senhas digitadas não correspondem.");
                        }
                      } else {
                        _mostrarPopUpErro(context,
                            "Todos os campos devem ser preenchidos para cadastrar um usuário.");
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width - 80, 50)),
                      backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(57, 0, 128, 1),
                      ),
                      foregroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(255, 255, 112, 1),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100), // Raio das bordas.
                        ),
                      ),
                    ),
                    child: const Text("Cadastrar"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    child: const Text(
                      "Já tem uma conta?",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 112, 1),
                        fontSize: 16,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _mostrarPopUpErro(BuildContext context, String msgDeErro) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: Text(msgDeErro),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}
