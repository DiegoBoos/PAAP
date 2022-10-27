import 'dart:io';

import 'package:paap/data/datasources/local/perfiles/perfiles_local_ds.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'datasources/local/auth/auth_local_ds.dart';
import 'datasources/local/menu/menu_local_ds.dart';

class DBConfig {
  static Database? _database;
  static final DBConfig db = DBConfig._();

  DBConfig._();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'paap.db');
    print('Ruta base: $path');
    //Crear base de datos
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      AuthLocalDataSourceImpl.createUserTable(db);
      MenuLocalDataSourceImpl.createMenuTable(db);
      PerfilesLocalDataSourceImpl.createSchemaPerfil(db);
    });

    return _database!;
  }

  void deleteDB() async {
    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'paap.db');

    //Eliminar base de datos
    databaseFactory.deleteDatabase(path);
  }
}
