import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import '../../../domain/cubits/perfil_preinversion_consultor/perfil_preinversion_consultor_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';
import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';

class PerfilPreInversionConsultoresRows extends StatelessWidget {
  const PerfilPreInversionConsultoresRows({
    Key? key,
    required this.consultores,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<ConsultorEntity> consultores;

  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionConsultorCubit =
        BlocProvider.of<PerfilPreInversionConsultorCubit>(
      context,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        dividerThickness: 1,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text('Consultor',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          DataColumn(
            label: Expanded(
              child:
                  Text('', style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
        ],
        rows: List.generate(consultores.length, (index) {
          ConsultorEntity consultor = consultores[index];

          return DataRow(cells: <DataCell>[
            DataCell(SizedBox(
                child: Text(
                    '${consultor.nombre1} ${consultor.nombre2} ${consultor.apellido1} ${consultor.apellido2}'))),
            DataCell(IconButton(
                onPressed: () async {
                  final perfilPreInversionConsultor =
                      PerfilPreInversionConsultorEntity(
                    perfilPreInversionId: vPerfilPreInversionCubit
                        .state.vPerfilPreInversion!.perfilId,
                    consultorId: consultor.consultorId,
                    // revisionId = 2 Segunda Revisión PreInversión - Factibilidad
                    revisionId: '2',
                    fechaRevision: DateTime.now().toIso8601String(),
                  );

                  await perfilPreInversionConsultorCubit
                      .savePerfilPreInversionConsultorDB(
                          perfilPreInversionConsultor);

                  if (perfilPreInversionConsultorCubit.state
                      is PerfilPreInversionConsultorSaved) {
                    BlocProvider.of<PerfilPreInversionConsultoresBloc>(context)
                        .add(GetPerfilPreInversionConsultores(
                            vPerfilPreInversionCubit.state.vPerfilPreInversion!
                                .perfilPreInversionId));
                  }
                },
                icon: const Icon(
                  Icons.person_add,
                  color: Colors.grey,
                ))),
          ]);
        }),
      ),
    );
  }
}
