import 'package:paap/data/models/perfil_model.dart';
import 'package:paap/domain/entities/perfil_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/perfiles_entity.dart';
import '../../../db_config.dart';
import '../../../models/perfiles_model.dart';

abstract class PerfilesLocalDataSource {
  Future<List<PerfilesModel>> getPerfilesDB();
  Future<List<Map<String, dynamic>>> getPerfilesFiltrosDB(
      String id, String nombre);
  Future<int> savePerfilesDB(List<PerfilesEntity> perfiles);
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Perfiles (
        ID	TEXT NOT NULL,
        Nombre	TEXT,
        Abreviatura	TEXT,
        Valor_x0020_Proyécto	TEXT,
        Incentivo_x0020_Módular	TEXT,
        Ubicación	TEXT,
        Categorización	TEXT
      )
    ''');
  }

  @override
  Future<List<PerfilesModel>> getPerfilesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Perfiles');

    final perfilesDB =
        List<PerfilesModel>.from(res.map((m) => PerfilesModel.fromJson(m)))
            .toList();

    return perfilesDB;
  }

  @override
  Future<List<Map<String, dynamic>>> getPerfilesFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    final res = await db.query('Perfiles');

    return res.toList();
  }

  @override
  Future<int> savePerfilesDB(List<PerfilesEntity> perfilesEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Perfiles');

    for (var perfil in perfilesEntity) {
      batch.insert('Perfiles', perfil.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
