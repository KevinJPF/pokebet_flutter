import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class PokemonData {
  int pokemonID = 0;
  String spriteUrl = '';
  String name = '';
  String firstType = '';
  String secondType = '';
  int captureRate = 0;
  int evolutionChainPosition = 0;
  bool isBaby = false;
  bool isLegendary = false;
  bool isMythical = false;
  bool hasGenderDifferences = false;
  bool isShiny = false;

  DateTime captureDate = DateTime.now();

  Stats stats = Stats();
}

class Stats {
  int attack = 0;
  double attackIV = 0;
  int defense = 0;
  double defenseIV = 0;
  int speed = 0;
  double speedIV = 0;
}

Future<PokemonData?> GetPokemonData(int id) async {
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

    newPokemon.isShiny = (Random().nextInt(100)) == 70;

    // Obter a URL do sprite do Pokémon (geralmente, é a primeira na lista)
    newPokemon.spriteUrl = pokemonData['sprites']['other']['official-artwork']
        ['front_${newPokemon.isShiny ? "shiny" : "default"}'];
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
    newPokemon.isBaby = (pokemonSpeciesData['is_baby']);
    newPokemon.isLegendary = (pokemonSpeciesData['is_legendary']);
    newPokemon.isMythical = (pokemonSpeciesData['is_mythical']);
    newPokemon.hasGenderDifferences =
        (pokemonSpeciesData['has_gender_differences']);

    return newPokemon;
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

int _calculateStat(int firstBaseStat, int secondBaseStat, double statIV) {
  int higherStat =
      (firstBaseStat > secondBaseStat ? firstBaseStat : secondBaseStat);
  int finalStat = (higherStat + ((higherStat * statIV) / 10)).round();

  return finalStat;
}

Future<int> _evolutionChainPosition(String urlPokemon) async {
  final responsePokemonSpecies = await http.get(Uri.parse(urlPokemon));
  final pokemonSpeciesData = json.decode(responsePokemonSpecies.body);

  return pokemonSpeciesData['evolves_from_species'] == null ? 1 : 2;
}
