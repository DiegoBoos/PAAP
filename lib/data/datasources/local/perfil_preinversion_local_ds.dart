import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../models/perfil_preinversion_model.dart';
import '../../models/v_perfil_preinversion_model.dart';

abstract class PerfilPreInversionLocalDataSource {
  Future<List<VPerfilPreInversionModel>> getPerfilesPreInversionDB();
  Future<List<VPerfilPreInversionModel>> getPerfilesPreInversionFiltrosDB(
      String id, String nombre);
  Future<int> savePerfilesPreInversionDB(
      List<PerfilPreInversionEntity> perfilesPreInversion);
  Future<PerfilPreInversionModel?> getPerfilPreInversionDB(String id);
}

class PerfilPreInversionLocalDataSourceImpl
    implements PerfilPreInversionLocalDataSource {
  static createPerfilPreInversionTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversion (
        PerfilPreInversionId	TEXT NOT NULL,
        PerfilId	TEXT NOT NULL,
        ConvocatoriaId	TEXT NOT NULL,
        Nombre	TEXT,
        Abreviatura	TEXT,
        NIT	TEXT,
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
        PRIMARY KEY(PerfilPreInversionId),
        FOREIGN KEY(PerfilId) REFERENCES Perfil(PerfilId),
        FOREIGN KEY(ProductoAsociadoId) REFERENCES ProductoAsociado(ProductoAsociadoId),
        FOREIGN KEY(TipoProyectoId) REFERENCES TipoProyecto(TipoProyectoId),
        FOREIGN KEY(ConvocatoriaId) REFERENCES Convocatoria(ConvocatoriaId),
        FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
        FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId)
      )
    ''');
  }

  @override
  Future<List<VPerfilPreInversionModel>> getPerfilesPreInversionDB() async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilPreInversionId as perfilPreInversionId,
    PerfilPreInversion.PerfilId as perfilId,
    Convocatoria.Nombre as convocatoria,
    PerfilPreInversion.Nombre as nombre, 
    PerfilPreInversion.Abreviatura as abreviatura, 
    NIT  as nit, 
    Municipio.Nombre  as municipio, 
    PerfilPreInversion.Direccion as direccion,
    PerfilPreInversion.Contacto as contacto,
    PerfilPreInversion.TelefonoFijo as telefonoFijo, 
    PerfilPreInversion.TelefonoMovil as telefonoMovil,
    PerfilPreInversion.Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    Producto.Nombre as producto,
    ProductoAsociado.Nombre as productoAsociado,
    PerfilPreInversion.ValorTotalProyecto as valorTotalProyecto,
    PerfilPreInversion.IncentivoModular as incentivoModular,
    Departamento.Nombre as Departamento
    from PerfilPreInversion
    left join Perfil on (Perfil.PerfilId=PerfilPreInversion.PerfilId)
    left join Convocatoria on (Convocatoria.ConvocatoriaId=PerfilPreInversion.ConvocatoriaId)
    left join Municipio on (Municipio.MunicipioId=PerfilPreInversion.MunicipioId)
    left join Departamento on (Departamento.DepartamentoId=Municipio.DepartamentoId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=PerfilPreInversion.TipoProyectoId)
    left join Producto on (Producto.ProductoId =PerfilPreInversion.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =PerfilPreInversion.ProductoAsociadoId)
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final vPerfilesPreInversionModel = List<VPerfilPreInversionModel>.from(
        res.map((m) => VPerfilPreInversionModel.fromJson(m))).toList();

    return vPerfilesPreInversionModel;
  }

  @override
  Future<List<VPerfilPreInversionModel>> getPerfilesPreInversionFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilPreInversionId as perfilPreInversionId,
    PerfilPreInversion.PerfilId as perfilId,
    Convocatoria.Nombre as convocatoria,
    PerfilPreInversion.Nombre as nombre, 
    PerfilPreInversion.Abreviatura as abreviatura, 
    NIT  as nit, 
    Municipio.Nombre  as municipio, 
    PerfilPreInversion.Direccion as direccion,
    PerfilPreInversion.Contacto as contacto,
    PerfilPreInversion.TelefonoFijo as telefonoFijo, 
    PerfilPreInversion.TelefonoMovil as telefonoMovil,
    PerfilPreInversion.Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    Producto.Nombre as producto,
    ProductoAsociado.Nombre as productoAsociado,
    PerfilPreInversion.ValorTotalProyecto as valorTotalProyecto,
    PerfilPreInversion.IncentivoModular as incentivoModular,
    Departamento.Nombre as Departamento
    from PerfilPreInversion
    left join Perfil on (Perfil.PerfilId=PerfilPreInversion.PerfilId)
    left join Convocatoria on (Convocatoria.ConvocatoriaId=PerfilPreInversion.ConvocatoriaId)
    left join Municipio on (Municipio.MunicipioId=PerfilPreInversion.MunicipioId)
    left join Departamento on (Departamento.DepartamentoId=Municipio.DepartamentoId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=PerfilPreInversion.TipoProyectoId)
    left join Producto on (Producto.ProductoId =PerfilPreInversion.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =PerfilPreInversion.ProductoAsociadoId)
    where PerfilPreInversionId LIKE '%$id%' AND PerfilPreInversion.Nombre LIKE '%$nombre%'
    ''';

    final res = await db.rawQuery(sql);

    final perfilesPreInversionDB = List<VPerfilPreInversionModel>.from(
        res.map((m) => VPerfilPreInversionModel.fromJson(m))).toList();

    return perfilesPreInversionDB;
  }

  @override
  Future<int> savePerfilesPreInversionDB(
      List<PerfilPreInversionEntity> perfilPreInversionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversion');

    for (var perfilPreInversion in perfilPreInversionEntity) {
      batch.insert('PerfilPreInversion', perfilPreInversion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<PerfilPreInversionModel?> getPerfilPreInversionDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversion',
        where: 'PerfilPreInversion = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreinversionMap = {
      for (var e in res[0].entries) e.key: e.value
    };

    final perfilPreinversionModel =
        PerfilPreInversionModel.fromJson(perfilPreinversionMap);

    return perfilPreinversionModel;
  }
}
