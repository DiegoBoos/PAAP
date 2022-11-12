import 'dart:io';

import 'package:paap/data/datasources/local/beneficiario_preinversion/beneficiario_preinversion_local_ds.dart';
import 'package:paap/data/datasources/local/tipo_actividad_productiva/tipo_actividad_productiva_local_ds.dart';
import 'package:paap/domain/usecases/visita/visita_exports.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources/local/actividad_economica/actividad_economica_local_ds.dart';
import '../../data/datasources/local/actividad_financiera/actividad_financiera_local_ds.dart';
import '../../data/datasources/local/agrupacion/agrupacion_local_ds.dart';
import '../../data/datasources/local/aliado/aliado_local_ds.dart';
import '../../data/datasources/local/alianzas/alianzas_local_ds.dart';
import '../../data/datasources/local/auth/auth_local_ds.dart';
import '../../data/datasources/local/beneficiario/beneficiario_local_ds.dart';
import '../../data/datasources/local/beneficiario_alianza/beneficiario_alianza_local_ds.dart';
import '../../data/datasources/local/cofinanciador/cofinanciador_local_ds.dart';
import '../../data/datasources/local/consultor/consultor_local_ds.dart';
import '../../data/datasources/local/convocatoria/convocatoria_local_ds.dart';
import '../../data/datasources/local/criterio/criterio_local_ds.dart';
import '../../data/datasources/local/departamento/departamento_local_ds.dart';
import '../../data/datasources/local/desembolso/desembolso_local_ds.dart';
import '../../data/datasources/local/estado_civil/estado_civil_local_ds.dart';
import '../../data/datasources/local/estado_visita/estado_visita_local_ds.dart';
import '../../data/datasources/local/evaluacion/evaluacion_local_ds.dart';
import '../../data/datasources/local/frecuencia/frecuencia_local_ds.dart';
import '../../data/datasources/local/genero/genero_local_ds.dart';
import '../../data/datasources/local/grupo_especial/grupo_especial_local_ds.dart';
import '../../data/datasources/local/menu/menu_local_ds.dart';
import '../../data/datasources/local/municipio/municipio_local_ds.dart';
import '../../data/datasources/local/nivel_escolar/nivel_escolar_local_ds.dart';
import '../../data/datasources/local/opcion/opcion_local_ds.dart';
import '../../data/datasources/local/perfil/perfil_local_ds.dart';
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
import '../usecases/sitio_entrega/sitio_entrega_exports.dart';

class DBConfig {
  static Database? _database;
  static final DBConfig db = DBConfig._();

  DBConfig._();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = p.join(documentDirectory.path, 'paap.db');
    print('Ruta base: $path');
    //Crear base de datos
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await ActividadEconomicaLocalDataSourceImpl.createActividadEconomicaTable(
          db);
      await ActividadFinancieraLocalDataSourceImpl
          .createActividadFinancieraTable(db);
      await AgrupacionLocalDataSourceImpl.createAgrupacionTable(db);
      await AliadosLocalDataSourceImpl.createAliadoTable(db);
      await AlianzasLocalDataSourceImpl.createAlianzaTable(db);
      await AuthLocalDataSourceImpl.createUserTable(db);
      await BeneficiarioAlianzaLocalDataSourceImpl
          .createBeneficiarioAlianzaTable(db);
      await BeneficiarioLocalDataSourceImpl.createBeneficiarioTable(db);
      await BeneficiarioPreinversionLocalDataSourceImpl
          .createBeneficiarioPreinversionTable(db);
      await CofinanciadorLocalDataSourceImpl.createCofinanciadorTable(db);
      await ConsultorLocalDataSourceImpl.createConsultorTable(db);
      await ConvocatoriaLocalDataSourceImpl.createConvocatoriaTable(db);
      await DepartamentoLocalDataSourceImpl.createDepartamentoTable(db);
      await DesembolsoLocalDataSourceImpl.createDesembolsoTable(db);
      await EstadoCivilLocalDataSourceImpl.createEstadoCivilTable(db);
      await EstadoVisitaLocalDataSourceImpl.createEstadoVisitaTable(db);
      await FrecuenciaLocalDataSourceImpl.createFrecuenciaTable(db);
      await GeneroLocalDataSourceImpl.createGeneroTable(db);
      await GrupoEspecialLocalDataSourceImpl.createGrupoEspecialTable(db);
      await MenuLocalDataSourceImpl.createMenuTable(db);
      await MunicipioLocalDataSourceImpl.createMunicipioTable(db);
      await NivelEscolarLocalDataSourceImpl.createNivelEscolarTable(db);
      await PerfilLocalDataSourceImpl.createPerfilTable(db);
      await ProductoLocalDataSourceImpl.createProductoTable(db);
      await ResidenciaLocalDataSourceImpl.createResidenciaTable(db);
      await RevisionLocalDataSourceImpl.createRevisionTable(db);
      await RubroLocalDataSourceImpl.createRubroTable(db);
      await TipoActividadProductivaLocalDataSourceImpl
          .createTipoActividadProductivaTable(db);
      await TipoCalidadLocalDataSourceImpl.createTipoCalidadTable(db);
      await TipoEntidadLocalDataSourceImpl.createTipoEntidadTable(db);
      await TipoIdentificacionLocalDataSourceImpl.createTipoIdentificacionTable(
          db);
      await TipoMovimientoLocalDataSourceImpl.createTipoMovimientoTable(db);
      await TipoProyectoLocalDataSourceImpl.createTipoProyectoTable(db);
      await TipoTenenciaLocalDataSourceImpl.createTipoTenenciaTable(db);
      await TipoVisitaLocalDataSourceImpl.createTipoVisitaTable(db);
      await UnidadLocalDataSourceImpl.createUnidadTable(db);
      await VeredaLocalDataSourceImpl.createVeredaTable(db);
      await VisitaLocalDataSourceImpl.createVisitaTable(db);
      await EvaluacionLocalDataSourceImpl.createEvaluacionTable(db);
      await OpcionLocalDataSourceImpl.createOpcionTable(db);
      await CriterioLocalDataSourceImpl.createCriterioTable(db);
      await SitioEntregaLocalDataSourceImpl.createSitioEntregaTable(db);
    });

    return _database!;
  }

  void deleteDB() async {
    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = p.join(documentDirectory.path, 'paap.db');

    //Eliminar base de datos
    databaseFactory.deleteDatabase(path);
  }
}
