import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
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
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);
    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);
    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        dividerThickness: 1,
        columnSpacing: 10,
        dataRowHeight: 150,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text('ID',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          const DataColumn(
            label: Expanded(
              child: Text(''),
            ),
          ),
        ],
        rows: List.generate(perfilPreInversionCofinanciadores.length, (index) {
          PerfilPreInversionCofinanciadorEntity
              perfilPreInversionCofinanciador =
              perfilPreInversionCofinanciadores[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(perfilPreInversionCofinanciador.cofinanciadorId)),
            DataCell(IconButton(
                onPressed: () {
                  perfilPreInversionCofinanciadorCubit
                      .selectPerfilPreInversionCofinanciador(
                          perfilPreInversionCofinanciador);

                  perfilPreInversionCofinanciadorDesembolsoCubit
                      .selectPerfilPreInversionCofinanciadorDesembolso(
                          perfilPreInversionCofinanciador.cofinanciadorId);
                  perfilPreInversionCofinanciadorActividadFinancieraCubit
                      .selectPerfilPreInversionCofinanciadorActividadFinanciera(
                          perfilPreInversionCofinanciador.cofinanciadorId);
                  perfilPreInversionCofinanciadorRubroCubit
                      .selectPerfilPreInversionCofinanciadorRubro(
                          perfilPreInversionCofinanciador.cofinanciadorId);

                  Navigator.pushNamed(
                      context, 'NewEditVCofinanciadorPreInversion');
                },
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                ))),
          ]);
        }),
      ),
    );
  }
}
