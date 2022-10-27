import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/perfil_entity.dart';

import '../../../db_config.dart';
import '../../../models/perfil_model.dart';

abstract class PerfilesLocalDataSource {
  Future<List<PerfilModel>> getPerfilesDB();
  Future<List<PerfilModel>> getPerfilesFiltrosDB(String id, String nombre);
  Future<int> savePerfilesDB(List<PerfilEntity> perfiles);
  Future<PerfilModel?> getPerfilDB(String id);
}

class PerfilesLocalDataSourceImpl implements PerfilesLocalDataSource {
  static createSchemaPerfil(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Convocatoria (
        ConvocatoriaId	INTEGER NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        Recursos	INTEGER,
        PRIMARY KEY(ConvocatoriaId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Convocatoria (
        ConvocatoriaId	INTEGER NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        Recursos	INTEGER,
        PRIMARY KEY(ConvocatoriaId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoProyecto (
        TipoProyectoId	INTEGER NOT NULL,
        Name	TEXT,
        PRIMARY KEY(TipoProyectoId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Unidad (
        UnidadId	INTEGER NOT NULL,
        Nombre	TEXT,
        Simbolo	TEXT,
        PRIMARY KEY(UnidadId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Producto (
        ProductoId	INTEGER NOT NULL,
        Nombre	TEXT,
        UnidadId	INTEGER NOT NULL,
        EsProducto	INTEGER,
        EsAsociado	INTEGER,
        PRIMARY KEY(ProductoId),
        FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Departamento (
        DepartamentoId	INTEGER NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(DepartamentoId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Municipio (
        MunicipioId	INTEGER NOT NULL,
        Nombre	TEXT,
        DepartamentoId	TEXT NOT NULL,
        PRIMARY KEY(MunicipioId),
        FOREIGN KEY(DepartamentoId) REFERENCES Departamento(DepartamentoId)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Perfil (
	      PerfilId	TEXT NOT NULL,
	      ConvocatoriaId	TEXT NOT NULL,
	      Nombre	TEXT,
	      Abreviatura	TEXT,
	      MunicipioId	TEXT NOT NULL,
	      Direccion	TEXT,
	      Contacto	TEXT,
	      TelefonoFijo	TEXT,
	      TelefonoMovil	TEXT,
	      Correo	TEXT,
	      TipoProyectoId	TEXT NOT NULL,
	      ProductoId	TEXT NOT NULL,
	      ProductoAsociadoId	TEXT NOT NULL,
	      ValorTotalProyecto	TEXT,
	      IncentivoModular	TEXT,
	      PRIMARY KEY(PerfilId),
	      FOREIGN KEY(ConvocatoriaId) REFERENCES Convocatoria(ConvocatoriaId),
	      FOREIGN KEY(TipoProyectoId) REFERENCES TipoProyecto(TipoProyectoId),
	      FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
	      FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
	      FOREIGN KEY(ProductoAsociadoId) REFERENCES Producto(ProductoId)
      )
    ''');

    /*  await db.execute('''
      CREATE TABLE IF NOT EXISTS Perfiles (
        ID	TEXT NOT NULL,
        Nombre	TEXT,
        Abreviatura	TEXT,
        Valor_x0020_Proyécto	TEXT,
        Incentivo_x0020_Módular	TEXT,
        Ubicación	TEXT,
        Categorización	TEXT
      )
    '''); */
  }

  @override
  Future<List<PerfilModel>> getPerfilesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Perfil');

    final perfilesDB =
        List<PerfilModel>.from(res.map((m) => PerfilModel.fromJson(m)))
            .toList();

    return perfilesDB;
  }

  @override
  Future<List<PerfilModel>> getPerfilesFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    final res = await db.query('Perfil',
        where: 'PerfilId LIKE ? AND Nombre LIKE ?',
        whereArgs: ['%$id%', '%$nombre%']);

    final perfilesDB =
        List<PerfilModel>.from(res.map((m) => PerfilModel.fromJson(m)))
            .toList();

    return perfilesDB;
  }

  @override
  Future<int> savePerfilesDB(List<PerfilEntity> perfilEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Perfil');

    for (var perfil in perfilEntity) {
      batch.insert('Perfil', perfil.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<PerfilModel?> getPerfilDB(String id) async {
    final db = await DBConfig.database;

    final res =
        await db.query('Perfil', where: 'PerfilId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilMap = {for (var e in res[0].entries) e.key: e.value};
    final perfilModel = PerfilModel.fromJson(perfilMap);

    return perfilModel;
  }
}
