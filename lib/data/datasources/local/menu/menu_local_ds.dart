import 'package:paap/data/models/menu_model.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../db_config.dart';

abstract class MenuLocalDataSource {
  Future<List<MenuModel>> getMenuDB();
  Future<int> saveMenu(List<MenuEntity> menuEntity);
}

class MenuLocalDataSourceImpl implements MenuLocalDataSource {
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
  Future<List<MenuModel>> getMenuDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Menu');

    final menusDB =
        List<MenuModel>.from(res.map((m) => MenuModel.fromJson(m))).toList();

    return menusDB;
  }

  @override
  Future<int> saveMenu(List<MenuEntity> menuEntity) async {
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
