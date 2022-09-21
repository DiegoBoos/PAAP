import 'package:sqflite/sqflite.dart';
import '../../datasources/local/db_config.dart';
import '../../models/perfil_model.dart';

class DBPerfiles {
  static createTablesPerfilModule(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ProjectType(
          id INTEGER PRIMARY KEY,
          name TEXT
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS MainProduct(
          id INTEGER PRIMARY KEY,
          name TEXT
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS AssociatedProduct(
          id INTEGER PRIMARY KEY,
          name TEXT
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS Department(
          id INTEGER PRIMARY KEY,
          name TEXT
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS City(
          id INTEGER PRIMARY KEY,
          name TEXT
        )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS Perfils(
          id INTEGER PRIMARY KEY,
          projectName TEXT,
          projectTypeId INTEGER,
          mainProductId INTEGER,
          associatedProductId INTEGER,
          departmentId INTEGER,
          cityId INTEGER,
          asociationName TEXT,
          address TEXT,
          contactName TEXT,
          email TEXT,
          phone INTEGER,
          cellPhone INTEGER,
          totalProjectValue INTEGER,
          modularIncentive INTEGER,
          FOREIGN KEY (projectTypeId) REFERENCES ProjectType (id),
          FOREIGN KEY (mainProductId) REFERENCES MainProduct (id),
          FOREIGN KEY (associatedProductId) REFERENCES AssociatedProduct (id),
          FOREIGN KEY (departmentId) REFERENCES Department (id),
          FOREIGN KEY (cityId) REFERENCES City (id)
        )''');
  }

  static Future<PerfilModel?> getPerfilById(int id) async {
    final db = await DBConfig.database;
    final res = await db.query('Perfils', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? PerfilModel.fromJson(res.first) : null;
  }

  static Future<List<PerfilModel>?> getAllPerfils() async {
    final db = await DBConfig.database;
    final res = await db.query('Perfils');

    return res.isNotEmpty
        ? res.map((perfil) => PerfilModel.fromJson(perfil)).toList()
        : [];
  }

  static Future<int> createPerfil(PerfilModel perfil) async {
    final db = await DBConfig.database;
    final res = await db.insert('Perfils', perfil.toJson());
    return res;
  }

  static Future<int> updatePerfil(PerfilModel newPerfil) async {
    final db = await DBConfig.database;

    final res = await db.update('Perfils', newPerfil.toJson(),
        where: 'id = ?', whereArgs: [newPerfil.id]);
    return res;
  }

  static Future<int> deletePerfil(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('Perfils', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  static Future<int> deleteAllPerfils(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('Perfils', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
