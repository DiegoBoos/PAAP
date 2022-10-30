import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/menu_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/menu_model.dart';

abstract class MenuLocalDataSource {
  Future<List<MenuModel>> getMenuDB();
  Future<MenuModel> saveMenu(MenuEntity menuEntity);
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
        PRIMARY KEY(MenuId),
        FOREIGN KEY(TipoMenuId) REFERENCES TipoMenu(TipoMenuId)
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
  Future<MenuModel> saveMenu(MenuEntity menuEntity) async {
    final db = await DBConfig.database;

    final menuJson = menuEntity.toJson();
    await db.insert('Menu', menuJson);
    return MenuModel.fromJson(menuJson);
  }
}
