import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/beneficiario_preinversion/beneficiario_preinversion_cubit.dart';
import '../../../domain/entities/beneficiario_preinversion_entity.dart';

class BeneficiariosPreinversionRows extends StatelessWidget {
  const BeneficiariosPreinversionRows({
    Key? key,
    required this.beneficiariosPreinversion,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<BeneficiarioPreinversionEntity> beneficiariosPreinversion;

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
        rows: List.generate(beneficiariosPreinversion.length, (index) {
          BeneficiarioPreinversionEntity beneficiarioPreinversion =
              beneficiariosPreinversion[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(beneficiarioPreinversion.beneficiarioId)),
            DataCell(Text(beneficiarioPreinversion.nombreOrganizacion)),
            DataCell(IconButton(
                onPressed: () {
                  final beneficiarioPreinversionCubit =
                      BlocProvider.of<BeneficiarioPreinversionCubit>(context);
                  beneficiarioPreinversionCubit.getBeneficiarioPreinversionDB(
                      beneficiarioPreinversion.beneficiarioId);
                  Navigator.pushNamed(context, 'VBeneficiarioPreInversion',
                      arguments: beneficiarioPreinversion);
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
