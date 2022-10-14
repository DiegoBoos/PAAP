import 'package:paap/domain/entities/usuario_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../db_config.dart';

abstract class AuthLocalDataSource {
  Future<List<Map<String, Object?>>> existeUsuario();
  Future<int> guardarUsuario(UsuarioEntity usuarioEntity);
  Future<List<Map>> logIn(String usuarioId);
  Future<List<Map<String, dynamic>>> getMenuDB();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static createUserTable(Database db) async {
    await db.execute('''
        CREATE TABLE Usuario (
          UsuarioId	TEXT NOT NULL,
          Nombre	TEXT,
          Apellido	TEXT,
          Direccion	TEXT,
          TelefonoFijo	TEXT,
          TelefonoMovil	TEXT,
          Correo	TEXT,
          Contrasena	TEXT,
          FechaActivacion	TEXT,
          FechaDesactivacion	TEXT,
          FechaCambio	TEXT,
          Activo	INTEGER,
          PRIMARY KEY(UsuarioId)
        )''');
  }

  static createMenuTable(Database db) async {
    await db.execute('''
        CREATE TABLE TipoMenu (
        TipoMenuId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(TipoMenuId)
      )''');
    await db.execute('''
        CREATE TABLE Menu (
        MenuId	TEXT NOT NULL,
        Nombre	TEXT,
        Ruta	TEXT,
        Icono	TEXT,
        Orden	TEXT,
        MenuPadre	TEXT,
        TipoMenuId	TEXT NOT NULL,
        FOREIGN KEY(TipoMenuId) REFERENCES TipoMenu(TipoMenuId),
        PRIMARY KEY("MenuId")
      )''');
  }

  @override
  Future<List<Map<String, Object?>>> existeUsuario() async {
    final db = await DBConfig.database;

    final res = await db.rawQuery('SELECT * FROM Usuario');

    return res.toList();
  }

  @override
  Future<int> guardarUsuario(UsuarioEntity usuarioEntity) async {
    final db = await DBConfig.database;

    final res = await db.insert('Usuario', usuarioEntity.toJson());
    return res;
  }

  @override
  Future<List<Map>> logIn(String usuarioId) async {
    final db = await DBConfig.database;

    final res =
        await db.query('SELECT * FROM Usuario WHERE usuarioId=$usuarioId');
    return res;
  }

  Future<int> logOut(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('UserAuth', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  @override
  Future<List<Map<String, Object?>>> getMenuDB() async {
    final db = await DBConfig.database;

    final res = await db.rawQuery('SELECT * FROM Menu');

    return res.toList();
  }
}
