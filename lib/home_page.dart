import 'package:flutter/material.dart';

import 'register_page.dart';
import 'userdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userList = <UserData>[];
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();

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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  ElevatedButton(
                    onPressed: () {
                      if (userList
                          .where((element) =>
                              element.username == controllerUserName.text &&
                              element.password == controllerPassword.text)
                          .isNotEmpty) {
                        _mostrarPopUpSucesso(
                            context,
                            userList
                                .where((element) =>
                                    element.username ==
                                        controllerUserName.text &&
                                    element.password == controllerPassword.text)
                                .first);
                      } else {
                        _mostrarPopUpErro(context);
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
                    child: const Text("Entrar"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    child: const Text(
                      "Esqueci Minha Senha",
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height - 70),
                    child: const Text(
                      "Não tem uma conta?",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );

                      if (result != null && result is UserData) {
                        userList.add(result);
                      }
                    },
                    child: const Text(
                      "Cadastre-se",
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

void _mostrarPopUpSucesso(BuildContext context, UserData userData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sucesso'),
        content: Text(
            'O login foi realizado com sucesso.\nUsuário: ${userData.username}\nEmail: ${userData.email}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}

void _mostrarPopUpErro(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Aviso'),
        content: Text('O usuário ou a senha digitados estão invalidos.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}
