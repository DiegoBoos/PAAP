import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import '../../../ui/cubits/perfil_preinversion_consultor/perfil_preinversion_consultor_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';
import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';

class PerfilPreInversionConsultoresTableSource extends DataTableSource {
  final BuildContext context;
  final List<ConsultorEntity> consultores;

  PerfilPreInversionConsultoresTableSource(this.context, this.consultores);

  @override
  DataRow getRow(int index) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionConsultorCubit =
        BlocProvider.of<PerfilPreInversionConsultorCubit>(
      context,
    );

    final consultor = consultores[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(consultor.consultor)),
        DataCell(IconButton(
            onPressed: () async {
              final perfilPreInversionConsultor =
                  PerfilPreInversionConsultorEntity(
                perfilPreInversionId: vPerfilPreInversionCubit
                    .state.vPerfilPreInversion!.perfilPreInversionId,
                consultorId: consultor.consultorId,
                // revisionId = 2 Segunda Revisión PreInversión - Factibilidad
                revisionId: '2',
                fechaRevision: DateTime.now().toIso8601String(),
              );

              await perfilPreInversionConsultorCubit
                  .savePerfilPreInversionConsultorDB(
                      perfilPreInversionConsultor)
                  .whenComplete(() {
                if (perfilPreInversionConsultorCubit.state
                    is PerfilPreInversionConsultorSaved) {
                  BlocProvider.of<PerfilPreInversionConsultoresBloc>(context)
                      .add(GetPerfilPreInversionConsultores(
                          vPerfilPreInversionCubit.state.vPerfilPreInversion!
                              .perfilPreInversionId));
                }
              });
            },
            icon: const Icon(Icons.person_add))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => consultores.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilPreInversionConsultoresRows extends StatelessWidget {
  const PerfilPreInversionConsultoresRows({
    Key? key,
    required this.consultores,
  }) : super(key: key);

  final List<ConsultorEntity> consultores;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: const Text('Consultores'),
      rowsPerPage: 5, // Adjust as needed
      columns: const <DataColumn>[
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Acción')),
      ],
      source: PerfilPreInversionConsultoresTableSource(context, consultores),
    );
  }
}
