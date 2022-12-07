import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
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
          AlianzaBeneficiarioEntity beneficiarioAlianza =
              alianzasBeneficiarios[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(beneficiarioAlianza.beneficiarioId)),
            DataCell(Text(beneficiarioAlianza.nombreOrganizacion)),
            DataCell(IconButton(
                onPressed: () {
                  final beneficiarioAlianzaCubit =
                      BlocProvider.of<AlianzaBeneficiarioCubit>(context);
                  beneficiarioAlianzaCubit
                      .selectAlianzaBeneficiario(beneficiarioAlianza);
                  Navigator.pushNamed(context, 'VBeneficiarioAlianza');
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
