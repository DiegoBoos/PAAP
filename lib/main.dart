import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/blocs/alianzas/alianzas_bloc.dart';
import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/blocs/beneficiarios_preinversion/beneficiarios_preinversion_bloc.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/blocs/perfiles/perfiles_bloc.dart';
import 'domain/cubits/actividad_economica/actividad_economica_cubit.dart';
import 'domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import 'domain/cubits/agrupacion/agrupacion_cubit.dart';
import 'domain/cubits/aliado/aliado_cubit.dart';
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
import 'domain/cubits/frecuencia/frecuencia_cubit.dart';
import 'domain/cubits/genero/genero_cubit.dart';
import 'domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/cubits/menu/menu_cubit.dart';
import 'domain/cubits/municipio/municipio_cubit.dart';
import 'domain/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import 'domain/cubits/opcion/opcion_cubit.dart';
import 'domain/cubits/producto/producto_cubit.dart';
import 'domain/cubits/residencia/residencia_cubit.dart';
import 'domain/cubits/revision/revision_cubit.dart';
import 'domain/cubits/rubro/rubro_cubit.dart';
import 'domain/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import 'domain/cubits/tipo_calidad/tipo_calidad_cubit.dart';
import 'domain/cubits/tipo_entidad/tipo_entidad_cubit.dart';
import 'domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import 'domain/cubits/tipo_movimiento/tipo_movimiento_cubit.dart';
import 'domain/cubits/tipo_proyecto/tipo_proyecto_cubit.dart';
import 'domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import 'domain/cubits/tipo_visita/tipo_visita_cubit.dart';
import 'domain/cubits/unidad/unidad_cubit.dart';
import 'domain/cubits/vereda/vereda_cubit.dart';
import 'domain/cubits/visita/visita_cubit.dart';

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
            create: (_) => di.locator<BeneficiariosPreinversionBloc>(),
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
