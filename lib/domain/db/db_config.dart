import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../../data/datasources/local/auth/auth_local_ds.dart';
import '../../data/datasources/local/convocatoria/convocatoria_local_ds.dart';
import '../../data/datasources/local/menu/menu_local_ds.dart';
import '../../data/datasources/local/perfiles/perfiles_local_ds.dart';
import '../../data/datasources/local/tipo_proyecto/tipo_proyecto_local_ds.dart';
import '../../data/datasources/local/unidad/unidad_local_ds.dart';

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
      ConvocatoriaLocalDataSourceImpl.createConvocatoriaTable(db);
      TipoProyectoLocalDataSourceImpl.createTipoProyectoTable(db);
      UnidadLocalDataSourceImpl.createUnidadTable(db);
      PerfilesLocalDataSourceImpl.createPerfilTable(db);
    });

    return _database!;
  }

  Future<int> truncateTable(String name) async {
    final db = await database;
    return await db.delete(name);
  }

  void deleteDB() async {
    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'paap.db');

    //Eliminar base de datos
    databaseFactory.deleteDatabase(path);
  }
}
