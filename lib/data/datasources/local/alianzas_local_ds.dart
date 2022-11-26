import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/alianza_entity.dart';

import '../../../domain/db/db_config.dart';
import '../../models/v_alianza_model.dart';

abstract class AlianzasLocalDataSource {
  Future<List<VAlianzaModel>> getAlianzasDB();
  Future<List<VAlianzaModel>> getAlianzasFiltrosDB(String id, String nombre);
  Future<int> saveAlianzasDB(List<AlianzaEntity> alianzas);
}

class AlianzasLocalDataSourceImpl implements AlianzasLocalDataSource {
  static createAlianzaTable(Database db) async {
    await db.execute('''
      CREATE TABLE Alianza (
        AlianzaId	TEXT NOT NULL,
        PerfilPreInversionId	TEXT NOT NULL,
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
        Legalizado	TEXT,
        PRIMARY KEY(AlianzaId),
        FOREIGN KEY(TipoProyectoId) REFERENCES TipoProyecto(TipoProyectoId),
        FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
        FOREIGN KEY(ProductoAsociadoId) REFERENCES Producto(ProductoId),
        FOREIGN KEY(ConvocatoriaId) REFERENCES Convocatoria(ConvocatoriaId)
      )
    ''');
  }

  @override
  Future<List<VAlianzaModel>> getAlianzasDB() async {
    final db = await DBConfig.database;

    String sql = '''
    select
    AlianzaId as alianzaId,
    PerfilPreInversionId as perfilPreInversionId,
    ConvocatoriaId as convocatoriaId,
    Alianza.Nombre as nombre, 
    Abreviatura as abreviatura, 
    NIT as nit, 
    Municipio.Nombre as municipio, 
    Direccion as direccion,
    Contacto as contacto,
    TelefonoFijo as telefonoFijo, 
    TelefonoMovil as telefonoMovil,
    Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    ProductoPrincipal.Nombre as productoPrincipal,
    ProductoAsociado.Nombre as productoAsociado,
    ValorTotalProyecto as valorTotalProyecto,
    IncentivoModular as incentivoModular,
    Legalizado as legalizado
    from Alianza
    left join Municipio on (Municipio.MunicipioId=Alianza.MunicipioId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=Alianza.TipoProyectoId)
    left join Producto as ProductoPrincipal on (ProductoPrincipal.ProductoId =Alianza.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =Alianza.ProductoAsociadoId)    
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final alianzasDB =
        List<VAlianzaModel>.from(res.map((m) => VAlianzaModel.fromJson(m)))
            .toList();

    return alianzasDB;
  }

  @override
  Future<List<VAlianzaModel>> getAlianzasFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    String sql = '''
    select
    AlianzaId as alianzaId,
    PerfilPreInversionId as perfilPreInversionId,
    ConvocatoriaId as convocatoriaId,
    Alianza.Nombre as nombre, 
    Abreviatura as abreviatura, 
    NIT as nit, 
    Municipio.Nombre as municipio, 
    Direccion as direccion,
    Contacto as contacto,
    TelefonoFijo as telefonoFijo, 
    TelefonoMovil as telefonoMovil,
    Correo as correo,
    TipoProyecto.Nombre as tipoProyecto,
    ProductoPrincipal.Nombre as productoPrincipal,
    ProductoAsociado.Nombre as productoAsociado,
    ValorTotalProyecto as valorTotalProyecto,
    IncentivoModular as incentivoModular
    Legalizado as legalizado
    from Alianza
    left join Municipio on (Municipio.MunicipioId=Alianza.MunicipioId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=Alianza.TipoProyectoId)
    left join Producto as ProductoPrincipal on (ProductoPrincipal.ProductoId =Alianza.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =Alianza.ProductoAsociadoId)
    where AlianzaId LIKE '%$id%' AND Alianza.Nombre LIKE '%$nombre%'
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final alianzasDB =
        List<VAlianzaModel>.from(res.map((m) => VAlianzaModel.fromJson(m)))
            .toList();

    return alianzasDB;
  }

  @override
  Future<int> saveAlianzasDB(List<AlianzaEntity> alianzaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Alianza');

    for (var alianza in alianzaEntity) {
      batch.insert('Alianza', alianza.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
