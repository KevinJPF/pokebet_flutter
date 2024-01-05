// ignore_for_file: non_constant_identifier_names

class UserData {
  final int? id;
  final String name;
  final String password;
  final String email;

  UserData({
    this.id,
    required this.name,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
    };
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
    );
  }
}

class Player {
  final int? id;
  final int level;
  final int experience;
  final int capturedPokemons;
  final int pokebetsParticipated;
  final int pokebetsWon;
  final int tournamentsParticipated;
  final int tournamentsWon;
  final int userId;

  Player({
    this.id,
    required this.level,
    required this.experience,
    required this.capturedPokemons,
    required this.pokebetsParticipated,
    required this.pokebetsWon,
    required this.tournamentsParticipated,
    required this.tournamentsWon,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'experience': experience,
      'captured_pokemons': capturedPokemons,
      'pokebets_participated': pokebetsParticipated,
      'pokebets_won': pokebetsWon,
      'tournaments_participated': tournamentsParticipated,
      'tournaments_won': tournamentsWon,
      'user_id': userId,
    };
  }
}

class UserPokemon {
  final int? id;
  final String name;
  final String nickname;
  final String firstType;
  final String? secondType;
  final int evolutionChainPosition;
  final int evolutionChainLimit;
  final int baby;
  final int legendary;
  final int mythical;
  final int shiny;
  final String gender;
  final String capturedAt;
  final double attack;
  final double attackIv;
  final double defense;
  final double defenseIv;
  final double speed;
  final double speedIv;
  final int pokedexNumber;
  final int playerId;

  UserPokemon({
    this.id,
    required this.name,
    required this.nickname,
    required this.firstType,
    this.secondType,
    required this.evolutionChainPosition,
    required this.evolutionChainLimit,
    required this.baby,
    required this.legendary,
    required this.mythical,
    required this.shiny,
    required this.gender,
    required this.capturedAt,
    required this.attack,
    required this.attackIv,
    required this.defense,
    required this.defenseIv,
    required this.speed,
    required this.speedIv,
    required this.pokedexNumber,
    required this.playerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'first_type': firstType,
      'second_type': secondType,
      'evolution_chain_position': evolutionChainPosition,
      'evolution_chain_limit': evolutionChainLimit,
      'baby': baby,
      'legendary': legendary,
      'mythical': mythical,
      'shiny': shiny,
      'gender': gender,
      'captured_at': capturedAt,
      'attack': attack,
      'attack_iv': attackIv,
      'defense': defense,
      'defense_iv': defenseIv,
      'speed': speed,
      'speed_iv': speedIv,
      'pokedex_number': pokedexNumber,
      'player_id': playerId,
    };
  }
}

class UserItem {
  final int? id;
  final String name;
  final int quantity;
  final int playerId;

  UserItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.playerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'player_id': playerId,
    };
  }
}
