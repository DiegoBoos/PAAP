import 'dart:io';

import 'package:paap/data/datasources/local/perfil_preinversion_aliado_local_ds.dart';
import 'package:paap/data/datasources/local/perfil_preinversion_beneficiario_local_ds.dart';
import 'package:paap/data/datasources/local/tipo_actividad_productiva_local_ds.dart';
import 'package:paap/domain/usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import 'package:paap/domain/usecases/experiencia_agricola/experiencia_agricola_exports.dart';
import 'package:paap/domain/usecases/visita/visita_exports.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasources/local/actividad_local_ds.dart';
import '../../data/datasources/local/actividad_economica_local_ds.dart';
import '../../data/datasources/local/actividad_financiera_local_ds.dart';
import '../../data/datasources/local/agrupacion_local_ds.dart';
import '../../data/datasources/local/aliado_local_ds.dart';
import '../../data/datasources/local/alianza_beneficiario_local_ds.dart';
import '../../data/datasources/local/alianzas_local_ds.dart';
import '../../data/datasources/local/auth_local_ds.dart';
import '../../data/datasources/local/beneficiario_local_ds.dart';

import '../../data/datasources/local/cofinanciador_local_ds.dart';
import '../../data/datasources/local/consultor_local_ds.dart';
import '../../data/datasources/local/convocatoria_local_ds.dart';
import '../../data/datasources/local/criterio_local_ds.dart';
import '../../data/datasources/local/departamento_local_ds.dart';
import '../../data/datasources/local/desembolso_local_ds.dart';
import '../../data/datasources/local/estado_civil_local_ds.dart';
import '../../data/datasources/local/estado_visita_local_ds.dart';
import '../../data/datasources/local/evaluacion_local_ds.dart';
import '../../data/datasources/local/experiencia_pecuaria_local_ds.dart';
import '../../data/datasources/local/frecuencia_local_ds.dart';
import '../../data/datasources/local/genero_local_ds.dart';
import '../../data/datasources/local/grupo_especial_local_ds.dart';
import '../../data/datasources/local/indicador_local_ds.dart';
import '../../data/datasources/local/menu_local_ds.dart';
import '../../data/datasources/local/meta_indicador_local_ds.dart';
import '../../data/datasources/local/municipio_local_ds.dart';
import '../../data/datasources/local/nivel_escolar_local_ds.dart';
import '../../data/datasources/local/objetivo_local_ds.dart';
import '../../data/datasources/local/opcion_local_ds.dart';
import '../../data/datasources/local/perfil_local_ds.dart';
import '../../data/datasources/local/perfil_beneficiario_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_cofinanciador_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_cofinanciador_actividad_financiera_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_cofinanciador_desembolso_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_cofinanciador_rubro_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_consultor_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_plan_negocio_local_ds.dart';
import '../../data/datasources/local/perfil_preinversion_precio_local_ds.dart';
import '../../data/datasources/local/producto_local_ds.dart';
import '../../data/datasources/local/producto_objetivo_local_ds.dart';
import '../../data/datasources/local/proyecto_local_ds.dart';
import '../../data/datasources/local/residencia_local_ds.dart';
import '../../data/datasources/local/revision_local_ds.dart';
import '../../data/datasources/local/rubro_local_ds.dart';
import '../../data/datasources/local/tipo_calidad_local_ds.dart';
import '../../data/datasources/local/tipo_discapacidad_local_ds.dart';
import '../../data/datasources/local/tipo_entidad_local_ds.dart';
import '../../data/datasources/local/tipo_identificacion_local_ds.dart';
import '../../data/datasources/local/tipo_movimiento_local_ds.dart';
import '../../data/datasources/local/tipo_proyecto_local_ds.dart';
import '../../data/datasources/local/tipo_tenencia_local_ds.dart';
import '../../data/datasources/local/tipo_visita_local_ds.dart';
import '../../data/datasources/local/unidad_local_ds.dart';
import '../../data/datasources/local/vereda_local_ds.dart';
import '../usecases/alianza_experiencia_agricola/alianza_experiencia_agricola_exports.dart';
import '../usecases/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_exports.dart';
import '../usecases/sitio_entrega/sitio_entrega_exports.dart';

class DBConfig {
  static Database? _database;
  static final DBConfig db = DBConfig._();

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
      await AlianzaBeneficiarioLocalDataSourceImpl
          .createAlianzaBeneficiarioTable(db);
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
      await EvaluacionRespuestaLocalDataSourceImpl
          .createEvaluacionRespuestaTable(db);
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
      await PerfilBeneficiarioLocalDataSourceImpl.createPerfilBeneficiarioTable(
          db);
      await ExperienciaAgricolaLocalDataSourceImpl
          .createExperienciaAgricolaTable(db);
      await ExperienciaPecuariaLocalDataSourceImpl
          .createExperienciaPecuariaTable(db);
      await AlianzaExperienciaAgricolaLocalDataSourceImpl
          .createAlianzaExperienciaAgricolaTable(db);
      await AlianzaExperienciaPecuariaLocalDataSourceImpl
          .createAlianzaExperienciaPecuariaTable(db);

      await ActividadLocalDataSourceImpl.createActividadTable(db);
      await IndicadorLocalDataSourceImpl.createIndicadorTable(db);
      await MetaIndicadorLocalDataSourceImpl.createMetaIndicadorTable(db);
      await ObjetivoLocalDataSourceImpl.createObjetivoTable(db);
      await ProductoObjetivoLocalDataSourceImpl.createProductoObjetivoTable(db);
      await ProyectoLocalDataSourceImpl.createProyectoTable(db);
    });

    return _database!;
  }

  DBConfig._();

  void deleteDB() async {
    //Path donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = p.join(documentDirectory.path, 'paap.db');

    //Eliminar base de datos
    databaseFactory.deleteDatabase(path);
  }
}
