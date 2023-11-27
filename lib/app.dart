import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_config.dart';
import 'ui/blocs/alianza_beneficiarios/alianza_beneficiarios_bloc.dart';
import 'ui/blocs/alianzas/alianzas_bloc.dart';
import 'ui/blocs/auth/auth_bloc.dart';
import 'ui/blocs/perfil_aliados/perfil_aliados_bloc.dart';
import 'ui/blocs/perfil_beneficiarios/perfil_beneficiarios_bloc.dart';
import 'ui/blocs/perfil_cofinanciadores/perfil_cofinanciadores_bloc.dart';
import 'ui/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import 'ui/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import 'ui/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import 'ui/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import 'ui/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import 'ui/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import 'ui/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import 'ui/blocs/perfiles/perfiles_bloc.dart';
import 'ui/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import 'ui/blocs/perfiles_preinversiones_precios/perfiles_preinversiones_precios_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/actividad_economica/actividad_economica_cubit.dart';
import 'ui/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import 'ui/cubits/agrupacion/agrupacion_cubit.dart';
import 'ui/cubits/aliado/aliado_cubit.dart';
import 'ui/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import 'ui/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import 'ui/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import 'ui/cubits/beneficiario/beneficiario_cubit.dart';
import 'ui/cubits/beneficio/beneficio_cubit.dart';
import 'ui/cubits/cofinanciador/cofinanciador_cubit.dart';
import 'ui/cubits/consultor/consultor_cubit.dart';
import 'ui/cubits/convocatoria/convocatoria_cubit.dart';
import 'ui/cubits/criterio/criterio_cubit.dart';
import 'ui/cubits/departamento/departamento_cubit.dart';
import 'ui/cubits/desembolso/desembolso_cubit.dart';
import 'ui/cubits/estado_civil/estado_civil_cubit.dart';
import 'ui/cubits/estado_visita/estado_visita_cubit.dart';
import 'ui/cubits/evaluacion/evaluacion_cubit.dart';
import 'ui/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import 'ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import 'ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import 'ui/cubits/frecuencia/frecuencia_cubit.dart';
import 'ui/cubits/genero/genero_cubit.dart';
import 'ui/cubits/grupo_especial/grupo_especial_cubit.dart';
import 'ui/cubits/internet/internet_cubit.dart';
import 'ui/cubits/menu/menu_cubit.dart';
import 'ui/cubits/municipio/municipio_cubit.dart';
import 'ui/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import 'ui/cubits/opcion/opcion_cubit.dart';
import 'ui/cubits/perfil_aliado/perfil_aliado_cubit.dart';
import 'ui/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import 'ui/cubits/perfil_cofinanciador/perfil_cofinanciador_cubit.dart';
import 'ui/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import 'ui/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import 'ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import 'ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import 'ui/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import 'ui/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import 'ui/cubits/perfil_preinversion_consultor/perfil_preinversion_consultor_cubit.dart';
import 'ui/cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import 'ui/cubits/producto/producto_cubit.dart';
import 'ui/cubits/residencia/residencia_cubit.dart';
import 'ui/cubits/revision/revision_cubit.dart';
import 'ui/cubits/rubro/rubro_cubit.dart';
import 'ui/cubits/sitio_entrega/sitio_entrega_cubit.dart';
import 'ui/cubits/slider/slider_cubit.dart';
import 'ui/cubits/sync_log/sync_log_cubit.dart';
import 'ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import 'ui/cubits/tipo_calidad/tipo_calidad_cubit.dart';
import 'ui/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import 'ui/cubits/tipo_entidad/tipo_entidad_cubit.dart';
import 'ui/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import 'ui/cubits/tipo_movimiento/tipo_movimiento_cubit.dart';
import 'ui/cubits/tipo_proyecto/tipo_proyecto_cubit.dart';
import 'ui/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import 'ui/cubits/tipo_visita/tipo_visita_cubit.dart';
import 'ui/cubits/unidad/unidad_cubit.dart';
import 'ui/cubits/v_alianza/v_alianza_cubit.dart';
import 'ui/cubits/v_perfil/v_perfil_cubit.dart';
import 'ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import 'ui/cubits/vereda/vereda_cubit.dart';
import 'ui/cubits/visita/visita_cubit.dart';
import 'data/db/db_config.dart';
import 'domain/usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/utils/styles.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  di.init();
  return MyApp(appConfig);
}

class MyApp extends StatefulWidget {
  final AppConfig appConfig;
  const MyApp(this.appConfig, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setAppConfig();
  }

  setAppConfig() async {
    final db = await DBConfig.database;

    Map<String, dynamic> appConfig = {
      "appName": widget.appConfig.appName,
      "flavor": widget.appConfig.flavor,
      "url": widget.appConfig.url,
    };

    await db.insert('AppConfig', appConfig);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorDesembolsoCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorDesembolsosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<
                PerfilPreInversionCofinanciadorActividadFinancieraCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<
                PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorRubroCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorRubrosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ExperienciaAgricolaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ExperienciaPecuariaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzaExperienciaAgricolaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzaExperienciaPecuariaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ActividadEconomicaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ActividadFinancieraCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AgrupacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilAliadosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AliadoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzasBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzasBeneficiariosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzaBeneficiarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VAlianzaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilBeneficiariosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilBeneficiarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<BeneficiarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionBeneficiariosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionBeneficiarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionAliadoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilCofinanciadoresBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CofinanciadorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ConsultorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ConvocatoriaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DepartamentoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DesembolsoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EstadoCivilCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EstadoVisitaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<FrecuenciaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GeneroCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GrupoEspecialCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<GrupoEspecialCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<InternetCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MenuCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MunicipioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<NivelEscolarCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DesembolsoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilesBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilAliadoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilBeneficiarioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilCofinanciadorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VPerfilCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilesPreInversionBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VPerfilPreInversionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionAliadosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ProductoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ResidenciaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<RevisionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<RubroCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoActividadProductivaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoCalidadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoDiscapacidadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoEntidadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoIdentificacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoMovimientoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoProyectoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoTenenciaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TipoVisitaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UnidadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VeredaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<VisitaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EvaluacionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<OpcionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<CriterioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SitioEntregaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EvaluacionRespuestaCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<
                PerfilPreInversionCofinanciadorActividadFinancieraCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorDesembolsoCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<PerfilPreInversionCofinanciadorRubroCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionCofinanciadoresBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionCofinanciadorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionConsultoresBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionConsultorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionPrecioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionCostosUPTCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionIngresosUPTCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilPreInversionPlanNegociosBloc>(),
          ),
          BlocProvider(
            create: (_) =>
                di.locator<VPerfilesPreInversionesPlanNegociosCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PerfilesPreInversionesPreciosBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SyncBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<BeneficioCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SyncLogCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SliderCubit>(),
          ),
        ],
        child: MaterialApp(
            title: 'PAAP',
            debugShowCheckedModeBanner:
                widget.appConfig.flavor == 'dev' ? true : false,
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Styles.lightGreen,
                    secondary: Styles.obscureGreen))));
  }
}
