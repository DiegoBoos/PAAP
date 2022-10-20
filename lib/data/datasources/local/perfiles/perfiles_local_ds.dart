import 'package:paap/domain/entities/perfil_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../db_config.dart';

abstract class PerfilesLocalDataSource {
  Future<List<Map<String, dynamic>>> getPerfilesDB();
  Future<List<Map<String, dynamic>>> getPerfilesFiltrosDB(
      String id, String nombre);
  Future<int> savePerfiles(List<PerfilEntity> perfiles);
}

class PerfilesLocalDataSourceImpl implements PerfilesLocalDataSource {
  static createConvocatoriaTable(Database db) async {
    await db.execute('''
      CREATE TABLE Convocatoria (
        ConvocatoriaId	INTEGER NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        Recursos	INTEGER,
        PRIMARY KEY(ConvocatoriaId)
      )
    ''');
  }

  static createTipoProyectoTable(Database db) async {
    await db.execute('''
      CREATE TABLE TipoProyecto (
        TipoProyectoId	INTEGER NOT NULL,
        Name	TEXT,
        PRIMARY KEY(TipoProyectoId)
      )
    ''');
  }

  static createUnidadTable(Database db) async {
    await db.execute('''
      CREATE TABLE Unidad (
        UnidadId	INTEGER NOT NULL,
        Nombre	TEXT,
        Simbolo	TEXT,
        PRIMARY KEY(UnidadId)
      )
    ''');
  }

  static createProductoTable(Database db) async {
    await db.execute('''
      CREATE TABLE Producto (
        ProductoId	INTEGER NOT NULL,
        Nombre	TEXT,
        UnidadId	INTEGER NOT NULL,
        EsProducto	INTEGER,
        EsAsociado	INTEGER,
        PRIMARY KEY(ProductoId),
        FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId)
      )
    ''');
  }

  static createDepartamentoTable(Database db) async {
    await db.execute('''
      CREATE TABLE Departamento (
        DepartamentoId	INTEGER NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(DepartamentoId)
      )
    ''');
  }

  static createMunicipioTable(Database db) async {
    await db.execute('''
      CREATE TABLE Municipio (
        MunicipioId	INTEGER NOT NULL,
        Nombre	TEXT,
        DepartamentoId	TEXT NOT NULL,
        PRIMARY KEY(MunicipioId),
        FOREIGN KEY(DepartamentoId) REFERENCES Departamento(DepartamentoId)
      )
    ''');
  }

  static createPerfilTable(Database db) async {
    await db.execute('''
      CREATE TABLE Perfil (
	      PerfilId	INTEGER NOT NULL,
	      ConvocatoriaId	INTEGER NOT NULL,
	      Nombre	TEXT,
	      Abreviatura	TEXT,
	      MunicipioId	INTEGER NOT NULL,
	      Direccion	TEXT,
	      Contacto	TEXT,
	      TelefonoFijo	TEXT,
	      TelefonoMovil	TEXT,
	      Correo	TEXT,
	      TipoProyectoId	INTEGER NOT NULL,
	      ProductoId	INTEGER NOT NULL,
	      ProductoAsociadoId	INTEGER NOT NULL,
	      ValorTotalProyecto	INTEGER,
	      IncentivoModular	INTEGER,
	      PRIMARY KEY(PerfilId),
	      FOREIGN KEY(ConvocatoriaId) REFERENCES Convocatoria(ConvocatoriaId),
	      FOREIGN KEY(TipoProyectoId) REFERENCES TipoProyecto(TipoProyectoId),
	      FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
	      FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
	      FOREIGN KEY(ProductoAsociadoId) REFERENCES Producto(ProductoId)
      )
    ''');
  }

  @override
  Future<List<Map<String, dynamic>>> getPerfilesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Perfil');

    return res.toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getPerfilesFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    final res = await db.query('Perfil');

    return res.toList();
  }

  @override
  Future<int> savePerfiles(List<PerfilEntity> perfilEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Perfil');

    for (var perfil in perfilEntity) {
      batch.insert('Perfil', perfil.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
