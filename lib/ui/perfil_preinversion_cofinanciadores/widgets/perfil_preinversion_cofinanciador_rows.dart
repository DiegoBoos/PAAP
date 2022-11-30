import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadoresRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadoresRows({
    Key? key,
    required this.perfilPreInversionCofinanciadores,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilPreInversionCofinanciadorEntity>
      perfilPreInversionCofinanciadores;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);
    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);
    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);
    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(context);
    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);

    return DataTable(
      headingRowColor:
          MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
      dividerThickness: 1,
      columnSpacing: 10,
      dataRowHeight: 150,
      columns: <DataColumn>[
        DataColumn(
          label: Expanded(
            child:
                Text('ID', style: subtitleStyle.copyWith(color: Colors.white)),
          ),
        ),
        const DataColumn(
          label: Expanded(
            child: Text(''),
          ),
        ),
      ],
      rows: List.generate(perfilPreInversionCofinanciadores.length, (index) {
        PerfilPreInversionCofinanciadorEntity perfilPreInversionCofinanciador =
            perfilPreInversionCofinanciadores[index];

        return DataRow(cells: <DataCell>[
          DataCell(Text(perfilPreInversionCofinanciador.cofinanciadorId)),
          DataCell(IconButton(
              onPressed: () {
                final vPerfilPreInversionId = vPerfilPreInversionCubit
                    .state.vPerfilPreInversion!.perfilPreInversionId;

                String cofinanciadorId = selectPerfilPreInversionCofinanciador(
                    perfilPreInversionCofinanciador,
                    perfilPreInversionCofinanciadorCubit);

                String desembolsoId =
                    selectPerfilPreInversionCofinanciadorDesembolso(
                        perfilPreInversionCofinanciadorDesembolsoCubit,
                        vPerfilPreInversionId,
                        cofinanciadorId);

                String actividadFinancieraId =
                    selectPerfilPreInversionCofinanciadorActividadFinanciera(
                        perfilPreInversionCofinanciadorActividadFinancieraCubit,
                        vPerfilPreInversionId,
                        cofinanciadorId,
                        desembolsoId);

                String rubroId = selectPerfilPreInversionCofinanciadorRubro(
                    perfilPreInversionCofinanciadorRubroCubit,
                    vPerfilPreInversionId,
                    cofinanciadorId,
                    actividadFinancieraId,
                    desembolsoId);

                perfilPreInversionCofinanciadorCubit.isEditing();

                perfilPreInversionCofinanciadorDesembolsosBloc.add(
                    GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                  perfilPreInversionId: vPerfilPreInversionId,
                  cofinanciadorId: cofinanciadorId,
                  desembolsoId: desembolsoId,
                ));
                perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
                    GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                        perfilPreInversionId: vPerfilPreInversionId,
                        cofinanciadorId: cofinanciadorId,
                        actividadFinancieraId: actividadFinancieraId,
                        desembolsoId: desembolsoId));
                perfilPreInversionCofinanciadorRubrosBloc.add(
                    GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                        perfilPreInversionId: vPerfilPreInversionId,
                        cofinanciadorId: cofinanciadorId,
                        actividadFinancieraId: actividadFinancieraId,
                        desembolsoId: desembolsoId,
                        rubroId: rubroId));

                Navigator.pushNamed(
                  context,
                  'NewEditVCofinanciadorPreInversion',
                );
              },
              icon: const Icon(
                Icons.keyboard_arrow_right,
              ))),
        ]);
      }),
    );
  }

  String selectPerfilPreInversionCofinanciador(
      PerfilPreInversionCofinanciadorEntity perfilPreInversionCofinanciador,
      PerfilPreInversionCofinanciadorCubit
          perfilPreInversionCofinanciadorCubit) {
    final cofinanciadorId = perfilPreInversionCofinanciador.cofinanciadorId;

    perfilPreInversionCofinanciadorCubit
        .selectPerfilPreInversionCofinanciador(perfilPreInversionCofinanciador);
    return cofinanciadorId;
  }

  String selectPerfilPreInversionCofinanciadorDesembolso(
      PerfilPreInversionCofinanciadorDesembolsoCubit
          perfilPreInversionCofinanciadorDesembolsoCubit,
      String vPerfilPreInversionId,
      String cofinanciadorId) {
    perfilPreInversionCofinanciadorDesembolsoCubit
        .selectPerfilPreInversionCofinanciadorDesembolso(
            vPerfilPreInversionId, cofinanciadorId);

    final desembolsoId = perfilPreInversionCofinanciadorDesembolsoCubit
        .state.perfilPreInversionCofinanciadorDesembolso.desembolsoId;
    return desembolsoId;
  }

  String selectPerfilPreInversionCofinanciadorActividadFinanciera(
      PerfilPreInversionCofinanciadorActividadFinancieraCubit
          perfilPreInversionCofinanciadorActividadFinancieraCubit,
      String vPerfilPreInversionId,
      String cofinanciadorId,
      String desembolsoId) {
    perfilPreInversionCofinanciadorActividadFinancieraCubit
        .selectPerfilPreInversionCofinanciadorActividadFinanciera(
            vPerfilPreInversionId, cofinanciadorId, desembolsoId);

    final actividadFinancieraId =
        perfilPreInversionCofinanciadorActividadFinancieraCubit
            .state
            .perfilPreInversionCofinanciadorActividadFinanciera
            .actividadFinancieraId;
    return actividadFinancieraId;
  }

  String selectPerfilPreInversionCofinanciadorRubro(
      PerfilPreInversionCofinanciadorRubroCubit
          perfilPreInversionCofinanciadorRubroCubit,
      String vPerfilPreInversionId,
      String cofinanciadorId,
      String actividadFinancieraId,
      String desembolsoId) {
    perfilPreInversionCofinanciadorRubroCubit
        .selectPerfilPreInversionCofinanciadorRubro(vPerfilPreInversionId,
            cofinanciadorId, actividadFinancieraId, desembolsoId);

    final rubroId = perfilPreInversionCofinanciadorRubroCubit
        .state.perfilPreInversionCofinanciadorRubro.rubroId;
    return rubroId;
  }
}
