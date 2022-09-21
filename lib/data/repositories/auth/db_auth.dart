import 'package:paap/data/models/usuario_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../datasources/local/db_config.dart';

class DBAuth {
  static createTablesAuth(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS UserAuth(
          idUser INTEGER,
          token TEXT,
          FOREIGN KEY (idUser) REFERENCES User (id),
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS User(
          id INTEGER PRIMARY KEY,
          email TEXT,
          password TEXT,
        )''');
  }

  static Future<int> logIn(UsuarioModel user) async {
    final db = await DBConfig.database;
    final res = await db.insert('User', user.toJson());
    return res;
  }

  static Future<int> logOut(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('UserAuth', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
