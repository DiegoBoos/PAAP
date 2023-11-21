import 'package:flutter/material.dart';

import '../../../domain/entities/beneficiario_entity.dart';

class BeneficiariosTableSource extends DataTableSource {
  final BuildContext context;
  final List<BeneficiarioEntity> beneficiarios;

  BeneficiariosTableSource(this.context, this.beneficiarios);

  @override
  DataRow getRow(int index) {
    final beneficiario = beneficiarios[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(beneficiario.beneficiarioId)),
        DataCell(TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'NewEditVBeneficiario',
                  arguments: beneficiario);
            },
            child: Text('${beneficiario.nombre1} ${beneficiario.apellido1}'))),

        // Add more cells for each column
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => beneficiarios.length;

  @override
  int get selectedRowCount => 0;
}

class BeneficiariosRows extends StatefulWidget {
  const BeneficiariosRows({
    Key? key,
    required this.beneficiarios,
  }) : super(key: key);

  final List<BeneficiarioEntity> beneficiarios;

  @override
  State<BeneficiariosRows> createState() => _BeneficiariosRowsState();
}

class _BeneficiariosRowsState extends State<BeneficiariosRows> {
  List<BeneficiarioEntity> beneficiariosFiltered = [];
  List<BeneficiarioEntity> allBeneficiarios = [];

  @override
  void initState() {
    super.initState();
    allBeneficiarios = widget.beneficiarios;
    beneficiariosFiltered = allBeneficiarios;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final beneficiarios = allBeneficiarios.where((beneficiario) {
      return beneficiario.nombre1.toLowerCase().contains(lowerCaseQuery) ||
          beneficiario.apellido1.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      beneficiariosFiltered = beneficiarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          onChanged: (value) => _buscar(value),
          decoration: const InputDecoration(
            labelText: 'Buscar',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        PaginatedDataTable(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Beneficiarios'),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'NewEditVBeneficiario');
                  },
                  icon: const Icon(
                    Icons.add,
                  ))
            ],
          ),
          rowsPerPage: 10,
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
          ],
          source: BeneficiariosTableSource(context, beneficiariosFiltered),
        ),
      ],
    );
  }
}
