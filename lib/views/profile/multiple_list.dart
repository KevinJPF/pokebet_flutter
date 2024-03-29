import 'package:pokebet/models/database_models.dart';
import 'package:pokebet/views/pokemon_profile.dart';
import 'package:pokebet/widgets/icon_container.dart';
import 'package:pokebet/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokebet/global.dart';
import 'package:pokebet/widgets/background.dart';

class MultipleList extends StatefulWidget {
  final List<UserPokemon>? listOfPokemon;
  final List<UserItem>? listOfItems;
  final String listName;
  const MultipleList(
      {super.key,
      this.listOfPokemon,
      this.listOfItems,
      required this.listName});

  @override
  State<MultipleList> createState() => _MultipleListState();
}

class _MultipleListState extends State<MultipleList> {
  List<UserPokemon>? _listOfPokemon = [];
  List<UserItem>? _listOfItems = [];

  @override
  void initState() {
    super.initState();
    _listOfPokemon = widget.listOfPokemon;
    _listOfItems = widget.listOfItems;
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
                            showBackButton: true, pageTitle: widget.listName),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        top: setHeight(80),
                        bottom: setHeight(40),
                      ),
                      child: ListView.builder(
                        itemCount: _listOfPokemon != null
                            ? _listOfPokemon!.length
                            : _listOfItems!.length,
                        itemBuilder: (context, index) {
                          if (_listOfPokemon != null) {
                            UserPokemon pokemon = _listOfPokemon![index];

                            return Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: setHeight(4)),
                              child: IconContainer(
                                icon: Icons.pets,
                                spriteUrl: pokemon.spriteImage,
                                isShiny: pokemon.shiny == 1,
                                mainText:
                                    '${pokemon.name}${pokemon.shiny == 1 ? ' ⋆' : ''}',
                                secondaryText:
                                    '${pokemon.firstType}${pokemon.secondType != null ? "/${pokemon.secondType}" : ""}',
                                rightFirstType: pokemon.firstType,
                                rightSecondType: pokemon.secondType != ''
                                    ? pokemon.secondType
                                    : null,
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PokemonProfile(
                                        pokemonData: pokemon,
                                        showBackButton: true,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            var item = _listOfItems![index];

                            return Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: setHeight(4)),
                              child: IconContainer(
                                icon: Icons.pets,
                                iconPNGName:
                                    item.name.toLowerCase().replaceAll(' ', ''),
                                mainText: item.name,
                                rightText: 'x${item.quantity}',
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // BottomMenuBar(),
            ],
          ),
        ),
      ),
    );
  }
}
