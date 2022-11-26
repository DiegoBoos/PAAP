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
                final perfilPreInversionId = vPerfilPreInversionCubit
                    .state.vPerfilPreInversion!.perfilPreInversionId;

                perfilPreInversionCofinanciadorCubit
                    .selectPerfilPreInversionCofinanciador(
                        perfilPreInversionCofinanciador);

                perfilPreInversionCofinanciadorCubit.isEditing();

                perfilPreInversionCofinanciadorDesembolsoCubit
                    .selectPerfilPreInversionCofinanciadorDesembolso(
                        perfilPreInversionId,
                        perfilPreInversionCofinanciador.cofinanciadorId,
                        perfilPreInversionCofinanciadorDesembolsoCubit
                            .state
                            .perfilPreInversionCofinanciadorDesembolso
                            .desembolsoId);
                perfilPreInversionCofinanciadorActividadFinancieraCubit
                    .selectPerfilPreInversionCofinanciadorActividadFinanciera(
                        perfilPreInversionId,
                        perfilPreInversionCofinanciador.cofinanciadorId,
                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .state
                            .perfilPreInversionCofinanciadorActividadFinanciera
                            .actividadFinancieraId,
                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .state
                            .perfilPreInversionCofinanciadorActividadFinanciera
                            .desembolsoId);
                perfilPreInversionCofinanciadorRubroCubit
                    .selectPerfilPreInversionCofinanciadorRubro(
                        perfilPreInversionId,
                        perfilPreInversionCofinanciador.cofinanciadorId,
                        perfilPreInversionCofinanciadorRubroCubit
                            .state.perfilPreInversionCofinanciadorRubro.desembolsoId,
                        perfilPreInversionCofinanciadorRubroCubit
                            .state
                            .perfilPreInversionCofinanciadorRubro
                            .actividadFinancieraId,
                        perfilPreInversionCofinanciadorRubroCubit.state
                            .perfilPreInversionCofinanciadorRubro.rubroId);

                perfilPreInversionCofinanciadorDesembolsosBloc.add(
                    GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId:
                            perfilPreInversionCofinanciador.cofinanciadorId));
                perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
                    GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId:
                            perfilPreInversionCofinanciador.cofinanciadorId));
                perfilPreInversionCofinanciadorRubrosBloc.add(
                    GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId:
                            perfilPreInversionCofinanciador.cofinanciadorId));

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
}
