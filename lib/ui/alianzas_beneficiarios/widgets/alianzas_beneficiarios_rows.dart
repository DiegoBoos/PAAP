import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../../domain/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../../domain/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';

class AlianzasBeneficiariosRows extends StatelessWidget {
  const AlianzasBeneficiariosRows({
    Key? key,
    required this.alianzasBeneficiarios,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<AlianzaBeneficiarioEntity> alianzasBeneficiarios;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final experienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        dividerThickness: 1,
        columnSpacing: 10,
        dataRowHeight: 200,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text('ID',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Nombre',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          const DataColumn(
            label: Expanded(
              child: Text(''),
            ),
          ),
        ],
        rows: List.generate(alianzasBeneficiarios.length, (index) {
          AlianzaBeneficiarioEntity alianzaBeneficiario =
              alianzasBeneficiarios[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(alianzaBeneficiario.beneficiarioId)),
            DataCell(Text(alianzaBeneficiario.nombreOrganizacion)),
            DataCell(IconButton(
                onPressed: () {
                  final tipoProyecto =
                      vAlianzaCubit.state.vAlianza!.tipoProyecto;

                  final beneficiarioId = alianzaBeneficiario.beneficiarioId;

                  alianzaBeneficiarioCubit
                      .selectAlianzaBeneficiario(alianzaBeneficiario);

                  beneficiarioCubit.loadBeneficiario(beneficiarioId);

                  if (tipoProyecto == 'Agrícola') {
                    experienciaAgricolaCubit.selectAlianzaExperienciaAgricola(
                        '1', beneficiarioId);
                  } else if (tipoProyecto == 'Pecuario') {
                    experienciaPecuariaCubit.selectAlianzaExperienciaPecuaria(
                        '1', beneficiarioId);
                  }
                  Navigator.pushNamed(context, 'NewEditVBeneficiarioAlianza');
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
