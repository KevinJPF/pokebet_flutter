// ignore_for_file: prefer_const_constructors

import 'package:PokeBet/database/db_connection.dart';
import 'package:PokeBet/models/database_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Global {
  // Global Variables
  static AppOptions appOptions = AppOptions(theme: 'dark');
  static PokebetColors pokebetColors = PokebetColors();
  static ValueNotifier<bool> isLogged = ValueNotifier(false);
  static bool canPopLogout = false;
  static bool isSearchingPokemon = false;

  // User data
  static UserData? userData;
  static List<UserPokemon> userPokemons = [];
  static List<UserItem> userItems = [];

  // Global Functions
  static void toggleTheme({bool toggle = true}) {
    if (toggle) {
      Global.appOptions.theme =
          Global.appOptions.theme == 'dark' ? 'light' : 'dark';
    }
    pokebetColors = PokebetColors();
    AppOptions.UpdateAppOptionsDatabase();
  }

  static Future<bool> loadInitialData({
    bool login = false,
    String? userName,
    String? userPassword,
  }) async {
    if (login) {
      userData = await LoadDatabase.userData(
          userName: userName, userPassword: userPassword);

      if (userData != null) {
        userPokemons = await LoadDatabase.userPokemonData();

        userItems = await LoadDatabase.userItemData();

        return true;
      } else {
        return false;
      }
    } else {
      userData = await LoadDatabase.userData();

      if (userData != null) {
        userPokemons = await LoadDatabase.userPokemonData();

        userItems = await LoadDatabase.userItemData();

        return true;
      } else {
        return false;
      }
    }
  }

  loadAppConfig() async {
    var appOptionsMap = (await DatabaseConnection()
            .selectDatabaseData(databaseTable: 'app_options'))
        .first;
    Global.appOptions = AppOptions.fromMap(appOptionsMap);
    toggleTheme(toggle: false);
  }

  static clearGlobal() {
    userData = null;
    userPokemons = [];
    userItems = [];
  }
}

class LoadDatabase {
  static Future<UserData?>? userData({
    String? userName,
    String? userPassword,
  }) async {
    Map<String, dynamic>? userMap;
    if (userName != null && userPassword != null) {
      userMap = (await DatabaseConnection().selectDatabaseData(
        databaseTable: 'users',
        where: 'name = ? and password = ?',
        whereArgs: [userName, userPassword],
      ))
          .firstOrNull;
    } else {
      userMap = (await DatabaseConnection().selectDatabaseData(
        databaseTable: 'users',
        where: 'remember_me = ?',
        whereArgs: ['1'],
      ))
          .firstOrNull;
    }
    if (userMap != null) {
      return UserData.fromMap(userMap);
    } else {
      return null;
    }
  }

  static Future<List<UserPokemon>> userPokemonData() async {
    List<Map<String, dynamic>>? userPokemonsDb =
        (await DatabaseConnection().selectDatabaseData(
      databaseTable: 'user_pokemons',
      where: 'user_id = ?',
      whereArgs: [
        Global.userData!.id.toString(),
      ],
    ));
    return UserPokemon.fromMapList(userPokemonsDb);
  }

  static Future<List<UserItem>> userItemData() async {
    List<Map<String, dynamic>>? userItemsDb =
        (await DatabaseConnection().selectDatabaseData(
      databaseTable: 'user_items',
      where: 'user_id = ?',
      whereArgs: [
        Global.userData!.id.toString(),
      ],
    ));
    return UserItem.fromMapList(userItemsDb);
  }

  static Future<List<UserItem>> appConfigurations() async {
    List<Map<String, dynamic>>? userItemsDb =
        (await DatabaseConnection().selectDatabaseData(
      databaseTable: 'user_items',
      where: 'user_id = ?',
      whereArgs: [
        Global.userData!.id.toString(),
      ],
    ));
    return UserItem.fromMapList(userItemsDb);
  }
}

class Types {
  static Map<String, Color> colors = {
    'bug': hexToColor('#92BC2C'),
    'dark': hexToColor('#595761'),
    'dragon': hexToColor('#0C69C8'),
    'electric': hexToColor('#F2D94E'),
    'fire': hexToColor('#FBA54C'),
    'fairy': hexToColor('#EE90E6'),
    'fighting': hexToColor('#D3425F'),
    'flying': hexToColor('#A1BBEC'),
    'ghost': hexToColor('#5F6DBC'),
    'grass': hexToColor('#5FBD58'),
    'ground': hexToColor('#DA7C4D'),
    'ice': hexToColor('#75D0C1'),
    'normal': hexToColor('#A0A29F'),
    'poison': hexToColor('#B763CF'),
    'psychic': hexToColor('#FA8581'),
    'rock': hexToColor('#C9BB8A'),
    'steel': hexToColor('#5695A3'),
    'water': hexToColor('#539DDF'),
  };
}

Color hexToColor(String code, {double opacity = 1.0}) {
  return Color(int.parse(code.substring(1, 7), radix: 16) +
      (opacity * 255).toInt() * 0x1000000);
}

double setHeight(double height) {
  return ScreenUtil().setHeight(height);
}

double setWidth(double width) {
  return ScreenUtil().setWidth(width);
}

double setFontSize(double fontSize) {
  return ScreenUtil().setSp(fontSize);
}

class PokebetColors {
  Color backgroundColor = _calculateColor('#170034', '#E0E4F2');
  Color frameColor = _calculateColor('#000000', '#959595', opacity: 0.3);
  Color whiteColor = _calculateColor('#FFFFFF', '#FFFFFF');
  Color highlightColor = _calculateColor('#FFFF6F', '#7148cf');
  Color showPasswordColor = _calculateColor('#7148cf', '#7148cf');
  Color buttonColor = _calculateColor('#390080', '#FFFFFF');
  Color buttonTextColor = _calculateColor('#FFFF6F', '#170034');
  Color simpleTextColor = _calculateColor('#FFFFFF', '#3F525D');
  Color simpleTextWhiteBackgroundColor = _calculateColor('#3F525D', '#3F525D');
  Color iconContainerIconBackColor = _calculateColor('#390080', '#3F525D');
}

Color _calculateColor(String hexDark, String hexLight, {double opacity = 1.0}) {
  return Global.appOptions.theme == 'dark'
      ? hexToColor(hexDark, opacity: opacity)
      : hexToColor(hexLight, opacity: opacity);
}
