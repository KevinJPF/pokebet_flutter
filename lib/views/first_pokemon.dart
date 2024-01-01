// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'dart:convert';
import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/views/player_profile.dart';
import 'package:PokeBet/views/pokemon_profile.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/pokemon_type.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:PokeBet/widgets/top_bar.dart';

class FirstPokemon extends StatefulWidget {
  const FirstPokemon({super.key});

  @override
  State<FirstPokemon> createState() => _FirstPokemonState();
}

class _FirstPokemonState extends State<FirstPokemon> {
  final controllerText = TextEditingController();
  bool showPokeballs = false;
  PokemonData? firstPokemon = null;
  PokemonData? secondPokemon = null;
  PokemonData? thirdPokemon = null;
  PokemonData? selectedPokemon = null;
  List<String> oakSpeak = [
    'Ah, olá ${Global.userName}! Como vai?',
    'Vejo que conseguiu chegar ao laboratório sem problemas. Pronto para iniciar sua grande jornada Pokémon?',
    'Me dê alguns segundos para que eu possa encontrar onde eu deixei os três Pokémons que selecionei especialmente para você.',
  ];

  @override
  void initState() {
    super.initState();

    generatePokemon(905, 200);
  }

  @override
  void dispose() {
    super.dispose();
  }

  generatePokemon(int pokemonQuantity, int maxStats) async {
    int totalStats;

    do {
      firstPokemon =
          await GetPokemonData(Random().nextInt(pokemonQuantity) + 1);
      totalStats = firstPokemon!.stats.attack +
          firstPokemon!.stats.defense +
          firstPokemon!.stats.speed;
    } while (firstPokemon!.evolutionChainPosition > 0 || totalStats > maxStats);
    print('Gerou um pokemon');

    do {
      secondPokemon =
          await GetPokemonData(Random().nextInt(pokemonQuantity) + 1);
      totalStats = secondPokemon!.stats.attack +
          secondPokemon!.stats.defense +
          secondPokemon!.stats.speed;
    } while (
        secondPokemon!.evolutionChainPosition > 0 || totalStats > maxStats);
    print('Gerou dois pokemon');

    do {
      thirdPokemon =
          await GetPokemonData(Random().nextInt(pokemonQuantity) + 1);
      totalStats = thirdPokemon!.stats.attack +
          thirdPokemon!.stats.defense +
          thirdPokemon!.stats.speed;
    } while (thirdPokemon!.evolutionChainPosition > 0 || totalStats > maxStats);
    print('Gerou tres pokemon');

    setState(() {});
  }

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
                      Background(hasLogo: false),
                      Column(
                        children: [
                          TopBar(),
                          Builder(builder: (context) {
                            if (thirdPokemon != null && showPokeballs) {
                              return Column(
                                children: [
                                  SimpleText('Aqui estão, escolha com calma.'),
                                  SizedBox(
                                    height: setHeight(16),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: setWidth(8)),
                                        child: GestureDetector(
                                          child: Image.asset(
                                            'assets/imgs/pokebola_${selectedPokemon == firstPokemon ? 'aberta' : 'iniciais'}.png',
                                            width: setWidth(80),
                                          ),
                                          onTap: () {
                                            print(
                                                'clicou na primeira pokebola');
                                            selectedPokemon =
                                                selectedPokemon == firstPokemon
                                                    ? null
                                                    : firstPokemon;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: setWidth(8)),
                                        child: GestureDetector(
                                          child: Image.asset(
                                            'assets/imgs/pokebola_${selectedPokemon == secondPokemon ? 'aberta' : 'iniciais'}.png',
                                            width: setWidth(80),
                                          ),
                                          onTap: () {
                                            print('clicou na segunda pokebola');
                                            selectedPokemon =
                                                selectedPokemon == secondPokemon
                                                    ? null
                                                    : secondPokemon;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: setWidth(8)),
                                        child: GestureDetector(
                                          child: Image.asset(
                                            'assets/imgs/pokebola_${selectedPokemon == thirdPokemon ? 'aberta' : 'iniciais'}.png',
                                            width: setWidth(80),
                                          ),
                                          onTap: () {
                                            print(
                                                'clicou na terceira pokebola');
                                            selectedPokemon =
                                                selectedPokemon == thirdPokemon
                                                    ? null
                                                    : thirdPokemon;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: setWidth(32)),
                                // color: Colors.pink,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/imgs/carvalho.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                    ),
                                    SizedBox(height: setHeight(16)),
                                    SimpleText(
                                      'Professor Carvalho',
                                      fontSize: 28,
                                    ),
                                    SizedBox(height: setHeight(16)),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SimpleText(
                                            oakSpeak[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                          Spacer(),
                          if (selectedPokemon != null) ...[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.6,
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: Colors.transparent,
                              child: Image.network(
                                selectedPokemon!.spriteUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SimpleText(
                              '#${selectedPokemon!.pokemonID} - ${selectedPokemon!.name}${selectedPokemon!.isShiny ? ' ⋆' : ''}',
                              fontColor: Global.highlightColor,
                              fontSize: 28,
                            ),
                            SizedBox(height: setHeight(16)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TypeIcon(selectedPokemon!.firstType),
                                if (selectedPokemon!.secondType != '') ...[
                                  SizedBox(width: setWidth(16)),
                                  TypeIcon(selectedPokemon!.secondType),
                                ]
                              ],
                            ),
                          ],
                          Spacer(),
                          Builder(builder: (context) {
                            if (thirdPokemon != null || oakSpeak.length > 1) {
                              return CustomButton(
                                buttonText: 'Avançar',
                                onPressed: () {
                                  if (selectedPokemon != null &&
                                      oakSpeak.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomPopup(
                                        popupTitle: "Aviso",
                                        popupMessage:
                                            "Tem certeza que deseja começar sua jornada com ${selectedPokemon!.name}?",
                                        firstButtonText: 'Fechar',
                                        secondButtonText: 'Confirmar',
                                        onPressedSecondButton: () {
                                          Global.userPokemons
                                              .add(selectedPokemon!);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PokemonProfile(
                                                pokemonData: selectedPokemon!,
                                                showBackButton: false,
                                                buttonText: 'Avançar',
                                                buttonOnPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlayerProfile(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    if (showPokeballs) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => CustomPopup(
                                          popupTitle: "Aviso",
                                          popupMessage:
                                              "Escolha um dos três Pokemons disponíveis para começar sua jornada!",
                                          firstButtonText: 'Fechar',
                                        ),
                                      );
                                    } else {
                                      oakSpeak.removeAt(0);
                                      showPokeballs = oakSpeak.isEmpty;
                                      setState(() {});
                                    }
                                  }
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Global.buttonColor,
                                ),
                              );
                            }
                          }),
                          SizedBox(
                            height: setHeight(32),
                          ),
                        ],
                      )
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

Future<String> getPokemonSpriteUrl(String id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    // A resposta foi bem-sucedida, analisar os dados JSON
    final data = json.decode(response.body);
    Random random = Random();
    bool isShiny = (random.nextInt(10) + 1) == 5;

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    final spriteUrl = data['sprites']['other']['official-artwork']
        ['front_${isShiny ? "shiny" : "default"}'];

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
