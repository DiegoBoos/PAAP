import 'package:paap/domain/entities/usuario_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../db_config.dart';

abstract class AuthLocalDataSource {
  Future<List<Map<String, dynamic>>> logIn(String usuarioId, String contrasena);
  Future<int> saveUsuario(UsuarioEntity usuarioEntity);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE Usuario(
        UsuarioId	TEXT NOT NULL,
        Nombre TEXT,
        Apellido TEXT,
        Direccion	TEXT,
        TelefonoFijo TEXT,
        TelefonoMovil	TEXT,
        Correo TEXT,
        Contrasena TEXT,
        FechaActivacion	TEXT,
        FechaDesactivacion TEXT,
        FechaCambio	TEXT,
        Activo INTEGER,
        PRIMARY KEY(UsuarioId)
      )
    ''');
  }

  @override
  Future<int> saveUsuario(UsuarioEntity usuarioEntity) async {
    final db = await DBConfig.database;

    await db.delete('Usuario',
        where: 'UsuarioId = ?', whereArgs: [usuarioEntity.usuarioId]);

    final res = await db.insert('Usuario', usuarioEntity.toJson());
    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> logIn(
      String usuarioId, String contrasena) async {
    final db = await DBConfig.database;

    final res = await db.query('Usuario',
        where: 'UsuarioId = ? AND Contrasena = ?',
        whereArgs: [usuarioId, contrasena]);
    return res;
  }

  Future<int> logOut(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('UserAuth', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
