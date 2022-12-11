import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadorRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadorRows({
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
      context,
    );

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(context);

    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(
      context,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary),
          dividerThickness: 1,
          columnSpacing: 10,
          dataRowHeight: 150,
          columns: <DataColumn>[
            DataColumn(label: Container()),
            DataColumn(
              label: Expanded(
                child: Text('CofinanciadorId',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Nombre',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Teléfono Móvil',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Correo',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Monto',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Participación',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
          ],
          rows:
              List.generate(perfilPreInversionCofinanciadores.length, (index) {
            PerfilPreInversionCofinanciadorEntity
                perfilPreInversionCofinanciador =
                perfilPreInversionCofinanciadores[index];

            final monto = NumberFormat.currency(
                    locale: 'en_US', decimalDigits: 0, symbol: "\$")
                .format(double.parse(perfilPreInversionCofinanciador.monto));

            return DataRow(cells: <DataCell>[
              DataCell(IconButton(
                  onPressed: perfilPreInversionCofinanciador.correo == 'TOTAL'
                      ? null
                      : () async {
                          final vPerfilPreInversionId = vPerfilPreInversionCubit
                              .state.vPerfilPreInversion!.perfilPreInversionId;

                          final cofinanciadorId =
                              perfilPreInversionCofinanciador.cofinanciadorId;

                          perfilPreInversionCofinanciadorCubit
                              .changeCofinanciador(cofinanciadorId);

                          perfilPreInversionCofinanciadorCubit.isEditing();

                          perfilPreInversionCofinanciadorDesembolsosBloc.add(
                              GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                                  perfilPreInversionId: vPerfilPreInversionId,
                                  cofinanciadorId: cofinanciadorId));

                          perfilPreInversionCofinanciadorActividadesFinancierasBloc
                              .add(
                                  GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                                      perfilPreInversionId:
                                          vPerfilPreInversionId,
                                      cofinanciadorId: cofinanciadorId));

                          perfilPreInversionCofinanciadorRubrosBloc.add(
                              GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                                  perfilPreInversionId: vPerfilPreInversionId,
                                  cofinanciadorId: cofinanciadorId));

                          final desembolso =
                              await perfilPreInversionCofinanciadorDesembolsoCubit
                                  .getPerfilPreInversionCofinanciadorDesembolso(
                                      vPerfilPreInversionId, cofinanciadorId);

                          final actividadFinanciera =
                              await perfilPreInversionCofinanciadorActividadFinancieraCubit
                                  .getPerfilPreInversionCofinanciadorActividadFinanciera(
                                      vPerfilPreInversionId,
                                      cofinanciadorId,
                                      desembolso?.desembolsoId ?? '');

                          await perfilPreInversionCofinanciadorRubroCubit
                              .getPerfilPreInversionCofinanciadorRubro(
                                  vPerfilPreInversionId,
                                  cofinanciadorId,
                                  desembolso?.desembolsoId ?? '',
                                  actividadFinanciera?.actividadFinancieraId ??
                                      '')
                              .whenComplete(() {
                            Navigator.pushNamed(
                              context,
                              'NewEditVCofinanciadorPreInversion',
                            );
                          });
                        },
                  icon: const Icon(
                    Icons.edit,
                  ))),
              DataCell(Text(perfilPreInversionCofinanciador.cofinanciadorId)),
              DataCell(Text(perfilPreInversionCofinanciador.nombre!)),
              DataCell(Text(perfilPreInversionCofinanciador.telefonoMovil!)),
              DataCell(Text(perfilPreInversionCofinanciador.correo!)),
              DataCell(Text(monto)),
              DataCell(Text(perfilPreInversionCofinanciador.participacion)),
            ]);
          }),
        ),
      ),
    );
  }
}
