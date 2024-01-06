// ignore_for_file: non_constant_identifier_names

import 'package:PokeBet/database/db_connection.dart';
import 'package:PokeBet/global.dart';

class UserData {
  final int? id;
  String name;
  String password;
  String email;
  int money;
  int level;
  int experience;
  int capturedPokemons;
  int pokebetsParticipated;
  int pokebetsWon;
  int tournamentsParticipated;
  int tournamentsWon;
  int firstLogin;
  int rememberMe;

  UserData({
    this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.money,
    required this.level,
    required this.experience,
    required this.capturedPokemons,
    required this.pokebetsParticipated,
    required this.pokebetsWon,
    required this.tournamentsParticipated,
    required this.tournamentsWon,
    required this.firstLogin,
    required this.rememberMe,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'money': money,
      'level': level,
      'experience': experience,
      'captured_pokemons': capturedPokemons,
      'pokebets_participated': pokebetsParticipated,
      'pokebets_won': pokebetsWon,
      'tournaments_participated': tournamentsParticipated,
      'tournaments_won': tournamentsWon,
      'first_login': firstLogin,
      'remember_me': rememberMe,
    };
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
      money: map['money'],
      level: map['level'],
      experience: map['experience'],
      capturedPokemons: map['captured_pokemons'],
      pokebetsParticipated: map['pokebets_participated'],
      pokebetsWon: map['pokebets_won'],
      tournamentsParticipated: map['tournaments_participated'],
      tournamentsWon: map['tournaments_won'],
      firstLogin: map['first_login'],
      rememberMe: map['remember_me'],
    );
  }

  static InsertUserDatabase(UserData newUser) {
    DatabaseConnection().insertDatabaseData(
        object: newUser.toMap(), databaseTable: 'users');
  }

  static UpdateUserDatabase() {
    DatabaseConnection().updateDatabaseData(
        object: Global.userData!.toMap(), databaseTable: 'users');
  }

  static DeleteUserDatabase(int id) {
    DatabaseConnection()
        .deleteDatabaseData(objectId: id, databaseTable: 'users');
  }
}

class UserPokemon {
  final int? id;
  String name;
  String nickname;
  String firstType;
  String? secondType;
  int evolutionChainPosition;
  final int evolutionChainLimit;
  final int baby;
  final int legendary;
  final int mythical;
  final int shiny;
  final String gender;
  String capturedAt;
  double attack;
  final double attackIv;
  double defense;
  final double defenseIv;
  double speed;
  final double speedIv;
  int pokedexNumber;
  String officialImage;
  String spriteImage;
  final int userId;

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
    required this.userId,
    required this.officialImage,
    required this.spriteImage,
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
      'user_id': userId,
      'official_image': officialImage,
      'sprite_image': spriteImage,
    };
  }

  static List<UserPokemon> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => fromMap(map)).toList();
  }

  static UserPokemon fromMap(Map<String, dynamic> map) {
    return UserPokemon(
      id: map['id'],
      name: map['name'],
      nickname: map['nickname'],
      firstType: map['first_type'],
      secondType: map['second_type'],
      evolutionChainPosition: map['evolution_chain_position'],
      evolutionChainLimit: map['evolution_chain_limit'],
      baby: map['baby'],
      legendary: map['legendary'],
      mythical: map['mythical'],
      shiny: map['shiny'],
      gender: map['gender'],
      capturedAt: map['captured_at'],
      attack: map['attack'],
      attackIv: map['attack_iv'],
      defense: map['defense'],
      defenseIv: map['defense_iv'],
      speed: map['speed'],
      speedIv: map['speed_iv'],
      pokedexNumber: map['pokedex_number'],
      userId: map['user_id'],
      officialImage: map['official_image'],
      spriteImage: map['sprite_image'],
    );
  }

  static InsertPokemonDatabase(UserPokemon newPokemon) {
    DatabaseConnection().insertDatabaseData(
        object: newPokemon.toMap(), databaseTable: 'user_pokemons');
  }

  static UpdatePokemonDatabase(UserPokemon updatedPokemon) {
    DatabaseConnection().updateDatabaseData(
        object: updatedPokemon.toMap(), databaseTable: 'user_pokemons');
  }

  static DeletePokemonDatabase(int id) {
    DatabaseConnection()
        .deleteDatabaseData(objectId: id, databaseTable: 'user_pokemons');
  }

  static DeleteAllUserPokemonDatabase(int userId) {
    DatabaseConnection()
        .deleteEverythingFromUser(userId: userId, databaseTable: 'user_pokemons');
  }
}

class UserItem {
  final int? id;
  final String name;
  int quantity;
  final int userId;

  UserItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'user_id': userId,
    };
  }

  static UserItem fromMap(Map<String, dynamic> map) {
    return UserItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      userId: map['user_id'],
    );
  }

  static List<UserItem> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => fromMap(map)).toList();
  }

  static InsertItemDatabase(UserItem newItem) {
    DatabaseConnection().insertDatabaseData(
        object: newItem.toMap(), databaseTable: 'user_items');
  }

  static UpdateItemDatabase(UserItem updatedItem) {
    DatabaseConnection().updateDatabaseData(
        object: updatedItem.toMap(), databaseTable: 'user_items');
  }

  static DeleteItemDatabase(int id) {
    DatabaseConnection()
        .deleteDatabaseData(objectId: id, databaseTable: 'user_items');
  }

  static DeleteAllUserItemDatabase(int userId) {
    DatabaseConnection()
        .deleteEverythingFromUser(userId: userId, databaseTable: 'user_items');
  }
}
