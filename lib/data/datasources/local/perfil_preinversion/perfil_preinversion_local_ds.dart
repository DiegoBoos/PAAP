import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../models/v_perfil_preinversion_model.dart';

abstract class PerfilPreinversionLocalDataSource {
  Future<List<VPerfilPreinversionModel>> getPerfilesPreinversionDB();
  Future<List<VPerfilPreinversionModel>> getPerfilesPreinversionFiltrosDB(
      String id, String nombre);
  Future<int> savePerfilesPreinversionDB(
      List<PerfilPreinversionEntity> perfilesPreinversion);
}

class PerfilPreinversionLocalDataSourceImpl
    implements PerfilPreinversionLocalDataSource {
  static createPerfilPreinversionTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreinversion (
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
  Future<List<VPerfilPreinversionModel>> getPerfilesPreinversionDB() async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilPreInversionId as perfilPreInversionId,
    PerfilId as perfilId,
    ConvocatoriaId as convocatoriaId,
    PerfilPreinversion.Nombre as nombre, 
    Abreviatura as abreviatura, 
    NIT  as nit, 
    Municipio.Nombre  as municipio, 
    Direccion as direccion,
    Contacto as contacto,
    TelefonoFijo as telefonoFijo, 
    TelefonoMovil as telefonoMovil,
    Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    Producto.Nombre as producto,
    ProductoAsociado.Nombre as productoAsociado,
    ValorTotalProyecto as valorTotalProyecto,
    IncentivoModular as incentivoModular
    from PerfilPreinversion
    left join Perfil on (Perfil.PerfilId=PerfilPreinversion.PerfilId)
    left join Convocatoria on (Convocatoria.ConvocatoriaId=PerfilPreinversion.ConvocatoriaId)
    left join Municipio on (Municipio.MunicipioId=PerfilPreinversion.MunicipioId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=PerfilPreinversion.TipoProyectoId)
    left join Producto on (Producto.ProductoId =PerfilPreinversion.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =PerfilPreinversion.ProductoAsociadoId)
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final vPerfilesPreinversionModel = List<VPerfilPreinversionModel>.from(
        res.map((m) => VPerfilPreinversionModel.fromJson(m))).toList();

    return vPerfilesPreinversionModel;
  }

  @override
  Future<List<VPerfilPreinversionModel>> getPerfilesPreinversionFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilPreInversionId as perfilPreInversionId,
    PerfilId as perfilId,
    PerfilPreinversion.ConvocatoriaId as convocatoriaId,
    PerfilPreinversion.Nombre as nombre, 
    Abreviatura as abreviatura, 
    NIT  as nit, 
    Municipio.Nombre  as municipio, 
    Direccion as direccion,
    Contacto as contacto,
    TelefonoFijo as telefonoFijo, 
    TelefonoMovil as telefonoMovil,
    Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    Producto.Nombre as producto,
    ProductoAsociado.Nombre as productoAsociado,
    ValorTotalProyecto as valorTotalProyecto,
    IncentivoModular as incentivoModular
    from PerfilPreinversion
    left join Convocatoria on (Convocatoria.ConvocatoriaId=PerfilPreinversion.ConvocatoriaId)
    left join Municipio on (Municipio.MunicipioId=PerfilPreinversion.MunicipioId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=PerfilPreinversion.TipoProyectoId)
    left join Producto on (Producto.ProductoId =PerfilPreinversion.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =PerfilPreinversion.ProductoAsociadoId)
    where PerfilPreinversionId LIKE '%$id%' AND PerfilPreinversion.Nombre LIKE '%$nombre%'
    ''';

    final res = await db.rawQuery(sql);

    final perfilesPreinversionDB = List<VPerfilPreinversionModel>.from(
        res.map((m) => VPerfilPreinversionModel.fromJson(m))).toList();

    return perfilesPreinversionDB;
  }

  @override
  Future<int> savePerfilesPreinversionDB(
      List<PerfilPreinversionEntity> perfilPreinversionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreinversion');

    for (var perfilPreinversion in perfilPreinversionEntity) {
      batch.insert('PerfilPreinversion', perfilPreinversion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
