import 'package:paap/domain/entities/menu_entity.dart';
import 'package:paap/domain/entities/usuario_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../db_config.dart';

abstract class AuthLocalDataSource {
  Future<List<Map<String, dynamic>>> logIn(String usuarioId, String contrasena);
  Future<int> guardarUsuario(UsuarioEntity usuarioEntity);
  Future<int> guardarMenu(List<MenuEntity> menuEntity);
  Future<List<Map<String, dynamic>>> getMenuDB();
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

  static createMenuTable(Database db) async {
    await db.execute('''
      CREATE TABLE Menu(
        MenuId TEXT NOT NULL,
        Nombre TEXT,
        Ruta TEXT,
        Icono TEXT,
        Orden TEXT,
        MenuPadre	TEXT,
        TipoMenuId TEXT NOT NULL,
        FOREIGN KEY(TipoMenuId) REFERENCES TipoMenu(TipoMenuId),
        PRIMARY KEY(MenuId)
      )
    ''');
  }

  @override
  Future<int> guardarUsuario(UsuarioEntity usuarioEntity) async {
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

    final res = await db.query(
        'Usuario WHERE UsuarioId="$usuarioId" and Contrasena="$contrasena"');
    return res;
  }

  Future<int> logOut(int id) async {
    final db = await DBConfig.database;

    final res = await db.delete('UserAuth', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getMenuDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Menu');

    return res.toList();
  }

  @override
  Future<int> guardarMenu(List<MenuEntity> menuEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Menu');

    for (var menu in menuEntity) {
      batch.insert('Menu', menu.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
