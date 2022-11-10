import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/usuario_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/usuario_model.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioEntity usuario);
  Future<int> verificacionDatosLocales();
  Future<int> saveUsuario(UsuarioEntity usuarioEntity);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Usuario(
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
        Activo TEXT,
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
  Future<UsuarioModel?> logIn(UsuarioEntity usuario) async {
    final db = await DBConfig.database;

    final res = await db.query('Usuario',
        where: 'UsuarioId = ? AND Contrasena = ?',
        whereArgs: [usuario.usuarioId, usuario.contrasena]);

    if (res.isEmpty) return null;

    final usuarioMap = {for (var e in res[0].entries) e.key: e.value};
    final usuarioModel = UsuarioModel.fromJson(usuarioMap);
    return usuarioModel;
  }

  Future<int> logOut(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('UserAuth', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  @override
  Future<int> verificacionDatosLocales() async {
    final db = await DBConfig.database;
    final res = await db.query('Usuario');
    if (res.isEmpty) return 0;
    return res.length;
  }
}
