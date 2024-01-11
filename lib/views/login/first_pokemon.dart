// ignore_for_file: prefer_const_constructors

import 'package:PokeBet/models/database_models.dart';
import 'package:PokeBet/models/pokemon_data.dart';
import 'package:PokeBet/views/profile/player_profile.dart';
import 'package:PokeBet/views/pokemon_profile.dart';
import 'package:PokeBet/widgets/custom_texts.dart';
import 'package:PokeBet/widgets/pokemon_type.dart';
import 'package:PokeBet/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/widgets/background.dart';
import 'package:PokeBet/widgets/custom_button.dart';
import 'package:PokeBet/widgets/top_bar.dart';

class FirstPokemon extends StatefulWidget {
  const FirstPokemon({super.key});

  @override
  State<FirstPokemon> createState() => _FirstPokemonState();
}

class _FirstPokemonState extends State<FirstPokemon> {
  final controllerText = TextEditingController();
  bool showPokeballs = false;
  bool triedToExploit = false;
  UserPokemon? firstPokemon;
  UserPokemon? secondPokemon;
  UserPokemon? thirdPokemon;
  UserPokemon? selectedPokemon;
  List<String> oakSpeak = [
    'Ah, olá ${Global.userData!.name}! Como vai?',
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
    if (Global.userPokemons.isEmpty) {
      firstPokemon = await FilterPokemon(
        filtrarResultados: true,
        canBeLegendary: false,
        maxStats: 200,
        shinyChances: 80,
        evolutionChainLimit: 0,
      );

      do {
        secondPokemon = await FilterPokemon(
          filtrarResultados: true,
          canBeLegendary: false,
          maxStats: 200,
          shinyChances: 80,
          evolutionChainLimit: 0,
        );
      } while (secondPokemon == firstPokemon);

      do {
        thirdPokemon = await FilterPokemon(
          filtrarResultados: true,
          canBeLegendary: false,
          maxStats: 200,
          shinyChances: 80,
          evolutionChainLimit: 0,
        );
      } while (thirdPokemon == secondPokemon || thirdPokemon == firstPokemon);
      setState(() {});

      UserPokemon.InsertPokemonDatabase(firstPokemon!);
      UserPokemon.InsertPokemonDatabase(secondPokemon!);
      UserPokemon.InsertPokemonDatabase(thirdPokemon!);
    } else {
      firstPokemon = Global.userPokemons[0];
      secondPokemon = Global.userPokemons[1];
      thirdPokemon = Global.userPokemons[2];

      triedToExploit = true;
      showPokeballs = true;
    }
  }

  registerFirstPokemonIntoDb() {
    UserPokemon.DeleteAllUserPokemonDatabase(Global.userData!.id!);
    Global.userPokemons.clear();
    Global.userPokemons.add(selectedPokemon!);
    UserPokemon.InsertPokemonDatabase(selectedPokemon!);
    Global.userData!.firstLogin = 0;
    Global.userData!.rememberMe = 1;
    UserData.UpdateUserDatabase();
  }

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
                          TopBar(showBackButton: false),
                          Builder(builder: (context) {
                            if (thirdPokemon != null && showPokeballs) {
                              if (triedToExploit) {
                                triedToExploit = false;
                                oakSpeak.clear();
                                Future.delayed(Duration.zero, () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomPopup(
                                      popupTitle: "SAFADOOOOO",
                                      popupMessage:
                                          "Vai roubar não canalha, vai ter que ser um desses 3 aí mesmo kkkkkkkkkkkk",
                                      firstButtonText: 'Fechar',
                                    ),
                                  );
                                });
                              }
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
                                selectedPokemon!.officialImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SimpleText(
                              '#${selectedPokemon!.pokedexNumber} - ${selectedPokemon!.name}${selectedPokemon!.shiny == 1 ? ' ⋆' : ''}',
                              fontColor: Global.pokebetColors.highlightColor,
                              fontSize: 28,
                            ),
                            SizedBox(height: setHeight(16)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TypeIcon(selectedPokemon!.firstType),
                                if (selectedPokemon!.secondType != null) ...[
                                  SizedBox(width: setWidth(16)),
                                  TypeIcon(selectedPokemon!.secondType!),
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
                                        onPressedSecondButton: () async {
                                          registerFirstPokemonIntoDb();

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
                                  color: Global.pokebetColors.buttonColor,
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
