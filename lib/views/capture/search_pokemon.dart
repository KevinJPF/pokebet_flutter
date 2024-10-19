import 'package:pokebet/models/database_models.dart';
import 'package:pokebet/models/pokemon_data.dart';
import 'package:pokebet/widgets/custom_button.dart';
import 'package:pokebet/widgets/custom_texts.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPokemon extends StatefulWidget {
  final String fieldImageName;
  final bool filtrarResultados;
  final int shinyChances;
  final bool canBeLegendary;
  final int maxStats;
  final List<String>? commonTypes;
  final List<String>? rareTypes;
  final int pokemonMinimumQuantity;
  final int pokemonMaximumQuantity;
  final int evolutionChainLimit;
  const SearchPokemon({
    super.key,
    required this.fieldImageName,
    this.filtrarResultados = false,
    this.shinyChances = 100,
    this.canBeLegendary = false,
    this.maxStats = 999,
    this.commonTypes,
    this.rareTypes,
    this.pokemonMinimumQuantity = 0,
    this.pokemonMaximumQuantity = 1017,
    this.evolutionChainLimit = 3,
  });

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  bool canPop = false;
  UserPokemon? foundPokemon;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;

    double availableHeight = screenHeight - safeAreaHeight;

    return Scaffold(
      backgroundColor: Global.pokebetColors.backgroundColor,
      body: SafeArea(
        child: Container(
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
                        TopBar(
                            showBackButton: true,
                            pageTitle: 'Procurar Pokemon'),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        top: setHeight(80),
                        bottom: setHeight(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Spacer(),
                          if (foundPokemon != null) ...[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.6,
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: Colors.transparent,
                              child: Image.network(
                                foundPokemon!.officialImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SimpleText(
                              '${foundPokemon!.name}${foundPokemon!.shiny == 1 ? ' ⋆' : ''}',
                              fontColor: Global.pokebetColors.highlightColor,
                              fontSize: 28,
                            ),
                            SizedBox(height: setHeight(16)),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: setWidth(32)),
                                  height: setHeight(100),
                                  width: setHeight(100),
                                  child: CustomButton(
                                    buttonImage: SvgPicture.asset(
                                      'assets/svgs/run.svg',
                                      colorFilter: ColorFilter.mode(
                                          Global.pokebetColors.highlightColor,
                                          BlendMode.srcIn),
                                    ),
                                    buttonText: '',
                                    onPressed: () async {
                                      foundPokemon = null;
                                      Global.isSearchingPokemon = false;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: setWidth(32)),
                                  height: setHeight(100),
                                  width: setHeight(100),
                                  child: CustomButton(
                                    buttonImage: SvgPicture.asset(
                                      'assets/svgs/Pokeball.svg',
                                      colorFilter: ColorFilter.mode(
                                          Global.pokebetColors.highlightColor,
                                          BlendMode.srcIn),
                                    ),
                                    buttonText: '',
                                    onPressed: () async {
                                      await UserPokemon.insertPokemonDatabase(
                                          foundPokemon!);
                                      Global.userPokemons.add(foundPokemon!);
                                      print('Capturou um pokemon');
                                      Global.userData!.money += 25;
                                      Global.userData!.experience += 25;
                                      Global.userData!.capturedPokemons++;
                                      await UserData.updateUserDatabase();
                                      foundPokemon = null;
                                      Global.isSearchingPokemon = false;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (Global.isSearchingPokemon &&
                              foundPokemon == null) ...[
                            Container(
                                // color: Colors.pink,
                                margin: EdgeInsets.all(setHeight(32)),
                                child: Image.asset('assets/imgs/search.gif')),
                            SimpleText(
                                'Procurando um Pokemon pelas redondezas...'),
                            Spacer(),
                          ] else if (foundPokemon == null) ...[
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: setWidth(32)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.asset(
                                        'assets/imgs/capture_places/${widget.fieldImageName}.jpg',
                                        fit: BoxFit.cover,
                                        height: setHeight(150),
                                        // width: setHeight(300),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SimpleText(
                                'Pokemons estão por perto, procure-os...'),
                            Spacer(),
                            SizedBox(height: setHeight(16)),
                            CustomButton(
                              buttonText: 'Procurar Pokemon',
                              onPressed: () async {
                                Global.isSearchingPokemon = true;
                                foundPokemon = null;
                                setState(() {});
                                foundPokemon = await filterPokemon(
                                  filtrarResultados: widget.filtrarResultados,
                                  shinyChances: widget.shinyChances,
                                  canBeLegendary: widget.canBeLegendary,
                                  maxStats: widget.maxStats,
                                  commonTypes: widget.commonTypes,
                                  rareTypes: widget.rareTypes,
                                  pokemonMinimumQuantity:
                                      widget.pokemonMinimumQuantity,
                                  pokemonMaximumQuantity:
                                      widget.pokemonMaximumQuantity,
                                  evolutionChainLimit:
                                      widget.evolutionChainLimit,
                                );
                                print('Gerou um pokemon');
                                setState(() {});
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
