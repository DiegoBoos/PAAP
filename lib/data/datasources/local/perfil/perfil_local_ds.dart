import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/perfil_entity.dart';

import '../../../../domain/db/db_config.dart';
import '../../../models/v_perfil_model.dart';

abstract class PerfilLocalDataSource {
  Future<List<VPerfilModel>> getPerfilesDB();
  Future<List<VPerfilModel>> getPerfilesFiltrosDB(String id, String nombre);
  Future<int> savePerfilesDB(List<PerfilEntity> perfiles);
}

class PerfilLocalDataSourceImpl implements PerfilLocalDataSource {
  static createPerfilTable(Database db) async {
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
  }

  @override
  Future<List<VPerfilModel>> getPerfilesDB() async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilId as perfilId,
    ConvocatoriaId as convocatoriaId,
    Perfil.Nombre as nombre, 
    Abreviatura as abreviatura, 
    Municipio.Nombre  as municipio, 
    Departamento.Nombre as departamento, 
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
    from Perfil
    left join Municipio on (Municipio.MunicipioId=Perfil.MunicipioId)
    left join Departamento on (Departamento.DepartamentoId=Municipio.DepartamentoId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=Perfil.TipoProyectoId)
    left join Producto as ProductoPrincipal on (ProductoPrincipal.ProductoId =Perfil.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =Perfil.ProductoAsociadoId)
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final vPerfilesModel =
        List<VPerfilModel>.from(res.map((m) => VPerfilModel.fromJson(m)))
            .toList();

    return vPerfilesModel;
  }

  @override
  Future<List<VPerfilModel>> getPerfilesFiltrosDB(
      String id, String nombre) async {
    final db = await DBConfig.database;

    String sql = '''
    select
    PerfilId as perfilId,
    ConvocatoriaId as convocatoriaId,
    Perfil.Nombre as nombre, 
    Abreviatura as abreviatura, 
    Municipio.Nombre  as municipio, 
    Departamento.Nombre as departamento, 
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
    from Perfil
    left join Municipio on (Municipio.MunicipioId=Perfil.MunicipioId)
    left join Departamento on (Departamento.DepartamentoId=Municipio.DepartamentoId)
    left join TipoProyecto on (TipoProyecto.TipoProyectoId=Perfil.TipoProyectoId)
    left join Producto as ProductoPrincipal on (ProductoPrincipal.ProductoId =Perfil.ProductoId)
    left join Producto as ProductoAsociado on (ProductoAsociado.ProductoId =Perfil.ProductoAsociadoId)
    where PerfilId LIKE '%$id%' AND Perfil.Nombre LIKE '%$nombre%'
    ''';

    final res = await db.rawQuery(sql);

    final perfilesDB =
        List<VPerfilModel>.from(res.map((m) => VPerfilModel.fromJson(m)))
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
}
