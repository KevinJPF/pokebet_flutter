import 'dart:convert';
import 'dart:math';
import 'package:PokeBet/global.dart';
import 'package:PokeBet/models/database_models.dart';
import 'package:http/http.dart' as http;

class PokemonData {
  int pokemonID = 0;
  String officalImageUrl = '';
  String spriteUrl = '';
  String name = '';
  String firstType = '';
  String secondType = '';
  int captureRate = 0;
  int evolutionChainPosition = 0;
  int isBaby = 0;
  int isLegendary = 0;
  int isMythical = 0;
  int hasGenderDifferences = 0;
  int isShiny = 0;

  DateTime captureDate = DateTime.now();

  Stats stats = Stats();
}

class Stats {
  double attack = 0;
  double attackIV = 0;
  double defense = 0;
  double defenseIV = 0;
  double speed = 0;
  double speedIV = 0;
}

Future<UserPokemon?> GetPokemonData(int id, {int shinyChances = 100}) async {
  PokemonData newPokemon = PokemonData();
  newPokemon.pokemonID = id;

  final responsePokemon =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
  final responsePokemonSpecies = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'));

  if (responsePokemon.statusCode == 200) {
    // A resposta foi bem-sucedida, analisar os dados JSON
    final pokemonData = json.decode(responsePokemon.body);
    final pokemonSpeciesData = json.decode(responsePokemonSpecies.body);

    var baseNumber = (Random().nextInt(shinyChances));
    newPokemon.isShiny = (Random().nextInt(shinyChances)) == baseNumber ? 1 : 0;

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    newPokemon.officalImageUrl = pokemonData['sprites']['other']
            ['official-artwork']
        ['front_${newPokemon.isShiny == 1 ? "shiny" : "default"}'];
    newPokemon.spriteUrl = pokemonData['sprites']
        ['front_${newPokemon.isShiny == 1 ? "shiny" : "default"}'];
    newPokemon.name = pokemonData['name'].toString().toUpperCase();
    newPokemon.firstType =
        pokemonData['types'][0]['type']['name'].toString().toUpperCase();
    newPokemon.secondType = pokemonData['types'].length == 1
        ? ''
        : pokemonData['types'][1]['type']['name'].toString().toUpperCase();

    // Calculate pokemon attack
    newPokemon.stats.attackIV = _calculateIV();
    newPokemon.stats.attack = _calculateStat(
      (pokemonData['stats'][1]['base_stat']),
      (pokemonData['stats'][3]['base_stat']),
      newPokemon.stats.attackIV,
    );

    // Calculate pokemon defense
    newPokemon.stats.defenseIV = _calculateIV();
    newPokemon.stats.defense = _calculateStat(
      (pokemonData['stats'][2]['base_stat']),
      (pokemonData['stats'][4]['base_stat']),
      newPokemon.stats.defenseIV,
    );

    // Calculate pokemon speed
    newPokemon.stats.speedIV = _calculateIV();
    newPokemon.stats.speed = _calculateStat(
      (pokemonData['stats'][5]['base_stat']),
      (pokemonData['stats'][5]['base_stat']),
      newPokemon.stats.speedIV,
    );

    newPokemon.captureRate = (pokemonSpeciesData['capture_rate']);
    newPokemon.evolutionChainPosition =
        pokemonSpeciesData['evolves_from_species'] == null
            ? 0
            : await _evolutionChainPosition(
                pokemonSpeciesData['evolves_from_species']['url']);
    newPokemon.isBaby = (pokemonSpeciesData['is_baby'] == 'true' ? 1 : 0);
    newPokemon.isLegendary =
        (pokemonSpeciesData['is_legendary'] == 'true' ? 1 : 0);
    newPokemon.isMythical =
        (pokemonSpeciesData['is_mythical'] == 'true' ? 1 : 0);
    newPokemon.hasGenderDifferences =
        (pokemonSpeciesData['has_gender_differences'] == 'true' ? 1 : 0);

    UserPokemon returnPokemon = UserPokemon(
      name: newPokemon.name,
      nickname: newPokemon.name,
      firstType: newPokemon.firstType,
      secondType: newPokemon.secondType != '' ? newPokemon.secondType : null,
      evolutionChainPosition: newPokemon.evolutionChainPosition,
      evolutionChainLimit: 0,
      baby: newPokemon.isBaby,
      legendary: newPokemon.isLegendary,
      mythical: newPokemon.isMythical,
      shiny: newPokemon.isShiny,
      gender: 'male',
      capturedAt: newPokemon.captureDate.toString(),
      attack: newPokemon.stats.attack,
      attackIv: newPokemon.stats.attackIV,
      defense: newPokemon.stats.defense,
      defenseIv: newPokemon.stats.defenseIV,
      speed: newPokemon.stats.speed,
      speedIv: newPokemon.stats.speedIV,
      pokedexNumber: newPokemon.pokemonID,
      userId: Global.userData!.id!,
      officialImage: newPokemon.officalImageUrl,
      spriteImage: newPokemon.spriteUrl,
    );

    return returnPokemon;
  } else {
    // A solicitação não foi bem-sucedida
    print('Request failed with status: ${responsePokemon.statusCode}');
    return null;
  }
}

double _calculateIV() {
  double newIV = ((Random.secure().nextDouble() * 2.1) - 1) > 1
      ? 1
      : ((Random.secure().nextDouble() * 2.1) - 1);
  return newIV;
}

double _calculateStat(int firstBaseStat, int secondBaseStat, double statIV) {
  int higherStat =
      (firstBaseStat > secondBaseStat ? firstBaseStat : secondBaseStat);
  double finalStat = (higherStat + ((higherStat * statIV) / 10));

  return finalStat;
}

Future<int> _evolutionChainPosition(String urlPokemon) async {
  final responsePokemonSpecies = await http.get(Uri.parse(urlPokemon));
  final pokemonSpeciesData = json.decode(responsePokemonSpecies.body);

  return pokemonSpeciesData['evolves_from_species'] == null ? 1 : 2;
}
