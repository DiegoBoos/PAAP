import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../datasources/local/actividad_economica_local_ds.dart';
import '../datasources/local/actividad_financiera_local_ds.dart';
import '../datasources/local/agrupacion_local_ds.dart';
import '../datasources/local/aliado_local_ds.dart';
import '../datasources/local/alianza_beneficiario_local_ds.dart';
import '../datasources/local/alianza_experiencia_agricola_local_ds.dart';
import '../datasources/local/alianza_experiencia_pecuaria_local_ds.dart';
import '../datasources/local/alianzas_local_ds.dart';
import '../datasources/local/auth_local_ds.dart';
import '../datasources/local/beneficiario_local_ds.dart';
import '../datasources/local/beneficio_local_ds.dart';
import '../datasources/local/cofinanciador_local_ds.dart';
import '../datasources/local/consultor_local_ds.dart';
import '../datasources/local/convocatoria_local_ds.dart';
import '../datasources/local/criterio_local_ds.dart';
import '../datasources/local/departamento_local_ds.dart';
import '../datasources/local/desembolso_local_ds.dart';
import '../datasources/local/estado_civil_local_ds.dart';
import '../datasources/local/estado_visita_local_ds.dart';
import '../datasources/local/evaluacion_local_ds.dart';
import '../datasources/local/evaluacion_respuesta_local_ds.dart';
import '../datasources/local/experiencia_agricola_local_ds.dart';
import '../datasources/local/experiencia_pecuaria_local_ds.dart';
import '../datasources/local/frecuencia_local_ds.dart';
import '../datasources/local/genero_local_ds.dart';
import '../datasources/local/grupo_especial_local_ds.dart';
import '../datasources/local/menu_local_ds.dart';
import '../datasources/local/municipio_local_ds.dart';
import '../datasources/local/nivel_escolar_local_ds.dart';
import '../datasources/local/opcion_local_ds.dart';
import '../datasources/local/perfil_aliado_local_ds.dart';
import '../datasources/local/perfil_beneficiario_local_ds.dart';
import '../datasources/local/perfil_cofinanciador_local_ds.dart';
import '../datasources/local/perfil_local_ds.dart';
import '../datasources/local/perfil_preinversion_aliado_local_ds.dart';
import '../datasources/local/perfil_preinversion_beneficiario_local_ds.dart';
import '../datasources/local/perfil_preinversion_cofinanciador_actividad_financiera_local_ds.dart';
import '../datasources/local/perfil_preinversion_cofinanciador_desembolso_local_ds.dart';
import '../datasources/local/perfil_preinversion_cofinanciador_local_ds.dart';
import '../datasources/local/perfil_preinversion_cofinanciador_rubro_local_ds.dart';
import '../datasources/local/perfil_preinversion_consultor_local_ds.dart';
import '../datasources/local/perfil_preinversion_local_ds.dart';
import '../datasources/local/perfil_preinversion_plan_negocio_local_ds.dart';
import '../datasources/local/perfil_preinversion_precio_local_ds.dart';
import '../datasources/local/producto_local_ds.dart';
import '../datasources/local/residencia_local_ds.dart';
import '../datasources/local/revision_local_ds.dart';
import '../datasources/local/rubro_local_ds.dart';
import '../datasources/local/sitio_entrega_local_ds.dart';
import '../datasources/local/tipo_actividad_productiva_local_ds.dart';
import '../datasources/local/tipo_calidad_local_ds.dart';
import '../datasources/local/tipo_discapacidad_local_ds.dart';
import '../datasources/local/tipo_entidad_local_ds.dart';
import '../datasources/local/tipo_identificacion_local_ds.dart';
import '../datasources/local/tipo_movimiento_local_ds.dart';
import '../datasources/local/tipo_proyecto_local_ds.dart';
import '../datasources/local/tipo_tenencia_local_ds.dart';
import '../datasources/local/tipo_visita_local_ds.dart';
import '../datasources/local/unidad_local_ds.dart';
import '../datasources/local/vereda_local_ds.dart';
import '../datasources/local/visita_local_ds.dart';

class DBConfig {
  DBConfig._();

  static Database? _database;
  static final DBConfig db = DBConfig._();

  static Future<Database> get database async {
    if (_database != null) return _database!;
    var path = "";
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Initialize FFI
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      path = p.join(".", "paap.db");
      print('Ruta base desktop: $path');

      //Crear base de datos
      _database = await databaseFactory.openDatabase(path);
      await createTables(_database!);
    } else {
      //Path donde se almacena la base de datos
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      path = p.join(documentDirectory.path, 'paap.db');
      print('Ruta base móvil: $path');

      //Crear base de datos
      _database = await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        await createTables(db);
      });
    }
    return _database!;
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS AppConfig (
        appName	TEXT,
        flavor	TEXT,
        url	TEXT
      )
    ''');

    await ActividadEconomicaLocalDataSourceImpl.createActividadEconomicaTable(
        db);
    await ActividadFinancieraLocalDataSourceImpl.createActividadFinancieraTable(
        db);
    await AgrupacionLocalDataSourceImpl.createAgrupacionTable(db);
    await AliadosLocalDataSourceImpl.createAliadoTable(db);
    await AlianzasLocalDataSourceImpl.createAlianzaTable(db);
    await AuthLocalDataSourceImpl.createUserTable(db);
    await AlianzaBeneficiarioLocalDataSourceImpl.createAlianzaBeneficiarioTable(
        db);
    await BeneficiarioLocalDataSourceImpl.createBeneficiarioTable(db);
    await PerfilPreInversionBeneficiarioLocalDataSourceImpl
        .createPerfilPreInversionBeneficiarioTable(db);
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
    await PerfilPreInversionLocalDataSourceImpl.createPerfilPreInversionTable(
        db);
    await PerfilLocalDataSourceImpl.createPerfilTable(db);
    await ProductoLocalDataSourceImpl.createProductoTable(db);
    await ResidenciaLocalDataSourceImpl.createResidenciaTable(db);
    await RevisionLocalDataSourceImpl.createRevisionTable(db);
    await RubroLocalDataSourceImpl.createRubroTable(db);
    await TipoActividadProductivaLocalDataSourceImpl
        .createTipoActividadProductivaTable(db);
    await TipoCalidadLocalDataSourceImpl.createTipoCalidadTable(db);
    await TipoDiscapacidadLocalDataSourceImpl.createTipoDiscapacidadTable(db);
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
    await EvaluacionRespuestaLocalDataSourceImpl.createEvaluacionRespuestaTable(
        db);
    await PerfilPreInversionAliadoLocalDataSourceImpl
        .createPerfilPreInversionAliadoTable(db);
    await PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSourceImpl
        .createPerfilPreInversionCofinanciadorActividadFinancieraTable(db);
    await PerfilPreInversionCofinanciadorDesembolsoLocalDataSourceImpl
        .createPerfilPreInversionCofinanciadorDesembolsoTable(db);
    await PerfilPreInversionCofinanciadorRubroLocalDataSourceImpl
        .createPerfilPreInversionCofinanciadorRubroTable(db);
    await PerfilPreInversionCofinanciadorLocalDataSourceImpl
        .createPerfilPreInversionCofinanciadorTable(db);
    await PerfilPreInversionConsultorLocalDataSourceImpl
        .createPerfilPreInversionConsultorTable(db);
    await PerfilPreInversionPrecioLocalDataSourceImpl
        .createPerfilPreInversionPrecioTable(db);
    await PerfilPreInversionPlanNegocioLocalDataSourceImpl
        .createPerfilPreInversionPlanNegocioTable(db);
    await PerfilAliadoLocalDataSourceImpl.createPerfilAliadoTable(db);
    await PerfilBeneficiarioLocalDataSourceImpl.createPerfilBeneficiarioTable(
        db);
    await PerfilCofinanciadorLocalDataSourceImpl.createPerfilCofinanciadorTable(
        db);
    await ExperienciaAgricolaLocalDataSourceImpl.createExperienciaAgricolaTable(
        db);
    await ExperienciaPecuariaLocalDataSourceImpl.createExperienciaPecuariaTable(
        db);
    await AlianzaExperienciaAgricolaLocalDataSourceImpl
        .createAlianzaExperienciaAgricolaTable(db);
    await AlianzaExperienciaPecuariaLocalDataSourceImpl
        .createAlianzaExperienciaPecuariaTable(db);
    await BeneficioLocalDataSourceImpl.createBeneficioTable(db);
  }
}
