import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  static Database? _database;
  static const String dbName = 'pokebet.db';

  // Função para verificar se o banco de dados já existe
  Future<bool> databaseExists(String path) async {
    return await databaseFactory.databaseExists(path);
  }

  Future<void> copyDatabase() async {
    // Caminho para o diretório onde o banco de dados será armazenado
    String customDatabasePath = join(await getDatabasesPath(), dbName);

    // Verifica se o banco de dados já existe
    bool dbExists = await databaseExists(customDatabasePath);

    if (!dbExists) {
      // Copia o arquivo de assets para o diretório do aplicativo
      ByteData data = await rootBundle.load('assets/database/pokebet.db');
      List<int> bytes = data.buffer.asUint8List();
      await File(customDatabasePath).writeAsBytes(bytes);
    }
  }

  // Função para abrir o banco de dados
  Future<void> openDb() async {
    // Chama a função de cópia antes de abrir o banco de dados
    await copyDatabase();

    // Abre o banco de dados
    _database = await openDatabase(
      join(await getDatabasesPath(), dbName), // Use o caminho novamente aqui
      version: 1,
      onCreate: (db, version) {
        // Adicione aqui a lógica para criação de tabelas se necessário
      },
    );
  }

  // Método para fechar o banco de dados
  Future<void> closeDb() async {
    await _database!.close();
  }

  // Método para inserir um novo usuário no banco de dados
  Future<int> insertDatabaseData(
      {required Map<String, dynamic> object,
      required String databaseTable}) async {
    return await _database!.insert(databaseTable, object);
  }

  // Método para buscar todos os usuários do banco de dados
  Future<List<Map<String, dynamic>>> selectDatabaseData({
    required String databaseTable,
    List<String>? columns,
    String? where,
    List<String>? whereArgs,
  }) async {
    return await _database!.query(
      databaseTable,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // Método para atualizar um usuário no banco de dados
  Future<int> updateDatabaseData(
      {required Map<String, dynamic> object,
      required String databaseTable}) async {
    return await _database!.update(
      databaseTable,
      object,
      where: 'id = ?',
      whereArgs: [object['id']],
    );
  }

  // Método para excluir um usuário do banco de dados
  Future<int> deleteDatabaseData(
      {required int objectId, required String databaseTable}) async {
    return await _database!.delete(
      databaseTable,
      where: 'id = ?',
      whereArgs: [objectId],
    );
  }
}
