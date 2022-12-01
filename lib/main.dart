import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/blocs/alianzas/alianzas_bloc.dart';
import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import 'domain/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import 'domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import 'domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import 'domain/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import 'domain/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import 'domain/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import 'domain/blocs/perfiles/perfiles_bloc.dart';
import 'domain/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import 'domain/blocs/upload_sync/upload_sync_bloc.dart';
import 'domain/cubits/actividad/actividad_cubit.dart';
import 'domain/cubits/actividad_economica/actividad_economica_cubit.dart';
import 'domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import 'domain/cubits/agrupacion/agrupacion_cubit.dart';
import 'domain/cubits/aliado/aliado_cubit.dart';
import 'domain/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import 'domain/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import 'domain/cubits/beneficiario/beneficiario_cubit.dart';
import 'domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import 'domain/cubits/consultor/consultor_cubit.dart';
import 'domain/cubits/convocatoria/convocatoria_cubit.dart';
import 'domain/cubits/criterio/criterio_cubit.dart';
import 'domain/cubits/departamento/departamento_cubit.dart';
import 'domain/cubits/desembolso/desembolso_cubit.dart';
import 'domain/cubits/estado_civil/estado_civil_cubit.dart';
import 'domain/cubits/estado_visita/estado_visita_cubit.dart';
import 'domain/cubits/evaluacion/evaluacion_cubit.dart';
import 'domain/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import 'domain/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import 'domain/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import 'domain/cubits/frecuencia/frecuencia_cubit.dart';
import 'domain/cubits/genero/genero_cubit.dart';
import 'domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import 'domain/cubits/indicador/indicador_cubit.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/cubits/menu/menu_cubit.dart';
import 'domain/cubits/meta_indicador/meta_indicador_cubit.dart';
import 'domain/cubits/municipio/municipio_cubit.dart';
import 'domain/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import 'domain/cubits/objetivo/objetivo_cubit.dart';
import 'domain/cubits/opcion/opcion_cubit.dart';
import 'domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import 'domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import 'domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import 'domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import 'domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import 'domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import 'domain/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import 'domain/cubits/perfil_preinversion_consultor/perfil_preinversion_consultor_cubit.dart';
import 'domain/cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import 'domain/cubits/producto/producto_cubit.dart';
import 'domain/cubits/producto_objetivo/producto_objetivo_cubit.dart';
import 'domain/cubits/proyecto/proyecto_cubit.dart';
import 'domain/cubits/residencia/residencia_cubit.dart';
import 'domain/cubits/revision/revision_cubit.dart';
import 'domain/cubits/rubro/rubro_cubit.dart';
import 'domain/cubits/sitio_entrega/sitio_entrega_cubit.dart';
import 'domain/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import 'domain/cubits/tipo_calidad/tipo_calidad_cubit.dart';
import 'domain/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import 'domain/cubits/tipo_entidad/tipo_entidad_cubit.dart';
import 'domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import 'domain/cubits/tipo_movimiento/tipo_movimiento_cubit.dart';
import 'domain/cubits/tipo_proyecto/tipo_proyecto_cubit.dart';
import 'domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import 'domain/cubits/tipo_visita/tipo_visita_cubit.dart';
import 'domain/cubits/unidad/unidad_cubit.dart';
import 'domain/cubits/v_perfil/v_perfil_cubit.dart';
import 'domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import 'domain/cubits/vereda/vereda_cubit.dart';
import 'domain/cubits/visita/visita_cubit.dart';
import 'domain/usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';
import 'injection.dart' as di;
import 'router.dart';
import 'ui/utils/styles.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            create: (_) => di.locator<ActividadCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<IndicadorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MetaIndicadorCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ObjetivoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ProductoObjetivoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<ProyectoCubit>(),
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
            create: (_) => di.locator<AliadoCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AlianzasBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthBloc>(),
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
            create: (_) => di.locator<UploadSyncBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<DownloadSyncBloc>(),
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
            create: (_) => di.locator<PerfilBeneficiarioCubit>(),
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
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.initialRoute,
            routes: AppRouter.routes,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Styles.lightGreen,
                    secondary: Styles.obscureGreen))));
  }
}
