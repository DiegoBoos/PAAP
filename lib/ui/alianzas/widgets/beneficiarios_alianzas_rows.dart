import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiariosAlianzasRows extends StatelessWidget {
  const BeneficiariosAlianzasRows({
    Key? key,
    required this.beneficiariosAlianzas,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<BeneficiarioAlianzaEntity> beneficiariosAlianzas;
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
        rows: List.generate(beneficiariosAlianzas.length, (index) {
          BeneficiarioAlianzaEntity beneficiarioAlianza =
              beneficiariosAlianzas[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(beneficiarioAlianza.beneficiarioAlianzaId)),
            DataCell(Text(beneficiarioAlianza.nombre1)),
            DataCell(IconButton(
                onPressed: () {
                  final beneficiarioAlianzaCubit =
                      BlocProvider.of<BeneficiarioAlianzaCubit>(context);
                  beneficiarioAlianzaCubit.getbeneficiarioAlianzaDB(
                      beneficiarioAlianza.beneficiarioAlianzaId);
                  Navigator.pushNamed(context, 'VbeneficiarioAlianzaAlianza',
                      arguments: beneficiarioAlianza.beneficiarioAlianzaId);
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
