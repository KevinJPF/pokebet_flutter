import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokebet_login/components/background.dart';
import 'package:pokebet_login/components/custom_button.dart';
import 'package:http/http.dart' as http;

class PokemonEgg extends StatefulWidget {
  const PokemonEgg({super.key});

  @override
  State<PokemonEgg> createState() => _PokemonEggState();
}

class _PokemonEggState extends State<PokemonEgg> {
  final controllerText = TextEditingController();
  String currentPokemonId = "25";
  String spriteUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif';
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
              const Background(hasLogo: false),
              Column(
                children: [
                  Spacer(),
                  FutureBuilder<String>(
                    future: getPokemonSpriteUrl(
                        currentPokemonId), // Obtenha a URL do sprite com base no Pokémon
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Se a solicitação for concluída, exiba a imagem
                        return Column(
                          children: [
                            Image.network(snapshot.data!),
                            SizedBox(
                              height: 20,
                            ),
                            FutureBuilder<String>(
                              future: getPokemonName(
                                  currentPokemonId), // Obtenha a URL do sprite com base no Pokémon
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // Se a solicitação for concluída, exiba a imagem
                                  return Text(
                                    snapshot.data!.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 112, 1),
                                      fontSize: 26,
                                      fontFamily: 'Georgia',
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  // Se ocorrer um erro, exiba uma mensagem de erro
                                  return Text('Erro ao carregar a imagem.');
                                } else {
                                  // Enquanto a solicitação estiver em andamento, você pode exibir um indicador de carregamento, se desejar
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        // Se ocorrer um erro, exiba uma mensagem de erro
                        return Text('Erro ao carregar a imagem.');
                      } else {
                        // Enquanto a solicitação estiver em andamento, você pode exibir um indicador de carregamento, se desejar
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: 'Generate Pokemon',
                    onPressed: () {
                      // Gere um novo ID de Pokémon aleatoriamente (ou da maneira desejada)
                      Random random = Random();
                      String newPokemonId = (random.nextInt(898) + 1)
                          .toString(); // Gere IDs de 1 a 898

                      setState(() {
                        currentPokemonId = newPokemonId;
                      });
                    },
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getPokemonSpriteUrl(String id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    // A resposta foi bem-sucedida, analisar os dados JSON
    final data = json.decode(response.body);

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    final spriteUrl = data['sprites']['front_default'];

    return spriteUrl;
  } else {
    // A solicitação não foi bem-sucedida
    print('Request failed with status: ${response.statusCode}');
    return "null";
  }
}

Future<String> getPokemonName(String id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    // A resposta foi bem-sucedida, analisar os dados JSON
    final data = json.decode(response.body);

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    final spriteUrl = data['name'];

    return spriteUrl;
  } else {
    // A solicitação não foi bem-sucedida
    print('Request failed with status: ${response.statusCode}');
    return "null";
  }
}
