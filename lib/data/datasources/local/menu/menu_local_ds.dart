import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/menu_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/menu_model.dart';

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
