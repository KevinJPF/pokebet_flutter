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

  DateTime captureDate = DateTime.now();

  Stats stats = Stats();
}

class PokemonSpeciesData {
  int captureRate = 0;
  int evolutionChainPosition = 0;
  int isBaby = 0;
  int isLegendary = 0;
  int isMythical = 0;
  int hasGenderDifferences = 0;
  int isShiny = 0;
}

class Stats {
  double attack = 0;
  double attackIV = 0;
  double defense = 0;
  double defenseIV = 0;
  double speed = 0;
  double speedIV = 0;
  double totalStats = 0;
}

Future<UserPokemon?> FilterPokemon({
  bool filtrarResultados = false,
  int shinyChances = 100,
  bool canBeLegendary = false,
  int maxStats = 999,
  List<String>? commonTypes,
  List<String>? rareTypes,
  int pokemonMinimumQuantity = 0,
  int pokemonMaximumQuantity = 1017,
  int evolutionChainLimit = 3,
}) async {
  PokemonData pokemonData = PokemonData();
  PokemonSpeciesData pokemonSpeciesData = PokemonSpeciesData();

  var baseNumber = (Random().nextInt(shinyChances));
  int generatedShiny = (Random().nextInt(shinyChances)) == baseNumber ? 1 : 0;
  bool pokemonDataPass = false;
  bool pokemonSpeciesPass = false;
  do {
    do {
      pokemonDataPass = false;
      int id =
          Random().nextInt(pokemonMaximumQuantity - pokemonMinimumQuantity) +
              pokemonMinimumQuantity;
      pokemonData = await getPokemonData(id, generatedShiny);
      print('Buscou Pokemon Data;');

      if (filtrarResultados) {
        List<String> sortedTypes = ((Random().nextInt(100) + 1) <= 70) ? commonTypes! : rareTypes!;
        if (pokemonData.stats.totalStats <= maxStats &&
            (sortedTypes.contains(pokemonData.firstType.toLowerCase()) || sortedTypes.contains(pokemonData.secondType.toLowerCase()))) {
          pokemonDataPass = true;
        }
      } else {
        pokemonDataPass = true;
      }
    } while (!pokemonDataPass);

    var pokemonSpeciesData =
        await getPokemonSpeciesData(pokemonData.pokemonID, generatedShiny);
      print('Buscou Pokemon Species;');

    if (filtrarResultados) {
      if (pokemonSpeciesData.evolutionChainPosition <= evolutionChainLimit) {
        if (!canBeLegendary) {
          pokemonSpeciesPass = pokemonSpeciesData.isLegendary == 0 &&
              pokemonSpeciesData.isMythical == 0;
        } else {
          pokemonSpeciesPass = true;
        }
      }
    } else {
      pokemonSpeciesPass = true;
    }
  } while (!pokemonSpeciesPass);

  // * Return Pokemon Data * \\
  UserPokemon returnPokemon = UserPokemon(
    name: pokemonData.name,
    nickname: pokemonData.name,
    firstType: pokemonData.firstType,
    secondType: pokemonData.secondType != '' ? pokemonData.secondType : null,
    evolutionChainPosition: pokemonSpeciesData.evolutionChainPosition,
    evolutionChainLimit: 0,
    baby: pokemonSpeciesData.isBaby,
    legendary: pokemonSpeciesData.isLegendary,
    mythical: pokemonSpeciesData.isMythical,
    shiny: pokemonSpeciesData.isShiny,
    gender: 'male',
    capturedAt: pokemonData.captureDate.toString(),
    attack: pokemonData.stats.attack,
    attackIv: pokemonData.stats.attackIV,
    defense: pokemonData.stats.defense,
    defenseIv: pokemonData.stats.defenseIV,
    speed: pokemonData.stats.speed,
    speedIv: pokemonData.stats.speedIV,
    pokedexNumber: pokemonData.pokemonID,
    userId: Global.userData!.id!,
    officialImage: pokemonData.officalImageUrl,
    spriteImage: pokemonData.spriteUrl,
  );
  return returnPokemon;
}

String sortTypes(
  List<String> commonTypes,
  List<String> rareTypes,
) {
  int whichType = Random().nextInt(100) + 1;

  if (whichType <= 70) {
    int typeIndex = Random().nextInt(commonTypes.length);

    return commonTypes[typeIndex];
  } else {
    int typeIndex = Random().nextInt(rareTypes.length);

    return rareTypes[typeIndex];
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
  // final responseEvolutionChain = await http
  //     .get(Uri.parse('https://pokeapi.co/api/v2/evolution-chain/$id'));

  final responsePokemonSpecies = await http.get(Uri.parse(urlPokemon));
  final pokemonSpeciesDataResponse = json.decode(responsePokemonSpecies.body);

  return pokemonSpeciesDataResponse['evolves_from_species'] == null ? 1 : 2;
}

Future<PokemonData> getPokemonData(int id, int generatedShiny) async {
  PokemonData pokemonData = PokemonData();

  final responsePokemonData =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (responsePokemonData.statusCode == 200) {
    // A resposta foi bem-sucedida, analisar os dados JSON
    pokemonData.pokemonID = id;
    final pokemonDataResponse = json.decode(responsePokemonData.body);

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    pokemonData.officalImageUrl = pokemonDataResponse['sprites']['other']
            ['official-artwork']
        ['front_${generatedShiny == 1 ? "shiny" : "default"}'];
    pokemonData.spriteUrl = pokemonDataResponse['sprites']
        ['front_${generatedShiny == 1 ? "shiny" : "default"}'];
    pokemonData.name = pokemonDataResponse['name'].toString().toUpperCase();
    pokemonData.firstType = pokemonDataResponse['types'][0]['type']['name']
        .toString()
        .toUpperCase();
    pokemonData.secondType = pokemonDataResponse['types'].length == 1
        ? ''
        : pokemonDataResponse['types'][1]['type']['name']
            .toString()
            .toUpperCase();

    // Calculate pokemon attack
    pokemonData.stats.attackIV = _calculateIV();
    pokemonData.stats.attack = _calculateStat(
      (pokemonDataResponse['stats'][1]['base_stat']),
      (pokemonDataResponse['stats'][3]['base_stat']),
      pokemonData.stats.attackIV,
    );

    // Calculate pokemon defense
    pokemonData.stats.defenseIV = _calculateIV();
    pokemonData.stats.defense = _calculateStat(
      (pokemonDataResponse['stats'][2]['base_stat']),
      (pokemonDataResponse['stats'][4]['base_stat']),
      pokemonData.stats.defenseIV,
    );

    // Calculate pokemon speed
    pokemonData.stats.speedIV = _calculateIV();
    pokemonData.stats.speed = _calculateStat(
      (pokemonDataResponse['stats'][5]['base_stat']),
      (pokemonDataResponse['stats'][5]['base_stat']),
      pokemonData.stats.speedIV,
    );

    pokemonData.stats.totalStats = pokemonData.stats.attack +
        pokemonData.stats.defense +
        pokemonData.stats.speed;
  }
  return pokemonData;
}

Future<PokemonSpeciesData> getPokemonSpeciesData(
    int id, int generatedShiny) async {
  PokemonSpeciesData pokemonSpeciesData = PokemonSpeciesData();
  final responsePokemonSpecies = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$id'));

  if (responsePokemonSpecies.statusCode == 200) {
    final pokemonSpeciesDataResponse = json.decode(responsePokemonSpecies.body);

    pokemonSpeciesData.isShiny = generatedShiny;
    pokemonSpeciesData.captureRate =
        (pokemonSpeciesDataResponse['capture_rate']);
    pokemonSpeciesData.evolutionChainPosition =
        pokemonSpeciesDataResponse['evolves_from_species'] == null
            ? 0
            : await _evolutionChainPosition(
                pokemonSpeciesDataResponse['evolves_from_species']['url']);
    pokemonSpeciesData.isBaby =
        (pokemonSpeciesDataResponse['is_baby'] ? 1 : 0);
    pokemonSpeciesData.isLegendary =
        (pokemonSpeciesDataResponse['is_legendary'] ? 1 : 0);
    pokemonSpeciesData.isMythical =
        (pokemonSpeciesDataResponse['is_mythical'] ? 1 : 0);
    pokemonSpeciesData.hasGenderDifferences =
        (pokemonSpeciesDataResponse['has_gender_differences']
            ? 1
            : 0);
  }
  return pokemonSpeciesData;
}
