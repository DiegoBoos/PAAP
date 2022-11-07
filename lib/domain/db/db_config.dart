import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../../data/datasources/local/actividad_financiera/actividad_financiera_local_ds.dart';
import '../../data/datasources/local/agrupacion/agrupacion_local_ds.dart';
import '../../data/datasources/local/aliado/aliado_local_ds.dart';
import '../../data/datasources/local/alianzas/alianzas_local_ds.dart';
import '../../data/datasources/local/auth/auth_local_ds.dart';
import '../../data/datasources/local/beneficiario/beneficiario_local_ds.dart';
import '../../data/datasources/local/cofinanciador/cofinanciador_local_ds.dart';
import '../../data/datasources/local/consultor/consultor_local_ds.dart';
import '../../data/datasources/local/convocatoria/convocatoria_local_ds.dart';
import '../../data/datasources/local/departamento/departamento_local_ds.dart';
import '../../data/datasources/local/desembolso/desembolso_local_ds.dart';
import '../../data/datasources/local/estado_civil/estado_civil_local_ds.dart';
import '../../data/datasources/local/estado_visita/estado_visita_local_ds.dart';
import '../../data/datasources/local/frecuencia/frecuencia_local_ds.dart';
import '../../data/datasources/local/genero/genero_local_ds.dart';
import '../../data/datasources/local/grupo_especial/grupo_especial_local_ds.dart';
import '../../data/datasources/local/menu/menu_local_ds.dart';
import '../../data/datasources/local/municipio/municipio_local_ds.dart';
import '../../data/datasources/local/nivel_escolar/nivel_escolar_local_ds.dart';
import '../../data/datasources/local/perfiles/perfiles_local_ds.dart';
import '../../data/datasources/local/producto/producto_local_ds.dart';
import '../../data/datasources/local/residencia/residencia_local_ds.dart';
import '../../data/datasources/local/revision/revision_local_ds.dart';
import '../../data/datasources/local/rubro/rubro_local_ds.dart';
import '../../data/datasources/local/tipo_calidad/tipo_calidad_local_ds.dart';
import '../../data/datasources/local/tipo_entidad/tipo_entidad_local_ds.dart';
import '../../data/datasources/local/tipo_identificacion/tipo_identificacion_local_ds.dart';
import '../../data/datasources/local/tipo_movimiento/tipo_movimiento_local_ds.dart';
import '../../data/datasources/local/tipo_proyecto/tipo_proyecto_local_ds.dart';
import '../../data/datasources/local/tipo_tenencia/tipo_tenencia_local_ds.dart';
import '../../data/datasources/local/tipo_visita/tipo_visita_local_ds.dart';
import '../../data/datasources/local/unidad/unidad_local_ds.dart';
import '../../data/datasources/local/vereda/vereda_local_ds.dart';

class DBConfig {
  static Database? _database;
  static final DBConfig db = DBConfig._();

  DBConfig._();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'paap.db');
    print('Ruta base: $path');
    //Crear base de datos
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await AuthLocalDataSourceImpl.createUserTable(db);
      await MenuLocalDataSourceImpl.createMenuTable(db);
      await ConvocatoriaLocalDataSourceImpl.createConvocatoriaTable(db);
      await TipoProyectoLocalDataSourceImpl.createTipoProyectoTable(db);
      await UnidadLocalDataSourceImpl.createUnidadTable(db);
      await ProductoLocalDataSourceImpl.createProductoTable(db);
      await GeneroLocalDataSourceImpl.createGeneroTable(db);
      await DepartamentoLocalDataSourceImpl.createDepartamentoTable(db);
      await MunicipioLocalDataSourceImpl.createMunicipioTable(db);
      await PerfilesLocalDataSourceImpl.createPerfilTable(db);
      await TipoVisitaLocalDataSourceImpl.createTipoVisitaTable(db);
      await EstadoVisitaLocalDataSourceImpl.createEstadoVisitaTable(db);
      await AgrupacionLocalDataSourceImpl.createAgrupacionTable(db);

      await EstadoCivilLocalDataSourceImpl.createEstadoCivilTable(db);
      await ResidenciaLocalDataSourceImpl.createResidenciaTable(db);
      await TipoTenenciaLocalDataSourceImpl.createTipoTenenciaTable(db);
      await NivelEscolarLocalDataSourceImpl.createNivelEscolarTable(db);
      await VeredaLocalDataSourceImpl.createVeredaTable(db);
      await AlianzasLocalDataSourceImpl.createAlianzaTable(db);
      await AliadosLocalDataSourceImpl.createAliadoTable(db);
      await FrecuenciaLocalDataSourceImpl.createFrecuenciaTable(db);
      await BeneficiarioLocalDataSourceImpl.createBeneficiarioTable(db);
      await GrupoEspecialLocalDataSourceImpl.createGrupoEspecialTable(db);
      await TipoIdentificacionLocalDataSourceImpl.createTipoIdentificacionTable(
          db);
      await RevisionLocalDataSourceImpl.createRevisionTable(db);
      await ConsultorLocalDataSourceImpl.createConsultorTable(db);
      await TipoEntidadLocalDataSourceImpl.createTipoEntidadTable(db);
      await CofinanciadorLocalDataSourceImpl.createCofinanciadorTable(db);
      await DesembolsoLocalDataSourceImpl.createDesembolsoTable(db);
      await RubroLocalDataSourceImpl.createRubroTable(db);
      await ActividadFinancieraLocalDataSourceImpl
          .createActividadFinancieraTable(db);
      await TipoMovimientoLocalDataSourceImpl.createTipoMovimientoTable(db);
      await TipoCalidadLocalDataSourceImpl.createTipoCalidadTable(db);
    });

    return _database!;
  }

  void deleteDB() async {
    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'paap.db');

    //Eliminar base de datos
    databaseFactory.deleteDatabase(path);
  }
}
