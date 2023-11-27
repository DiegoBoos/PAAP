import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/no_data_svg.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';

class PerfilBeneficiariosTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilBeneficiarioEntity> perfilBeneficiarios;

  PerfilBeneficiariosTableSource(this.context, this.perfilBeneficiarios);

  @override
  DataRow getRow(int index) {
    final perfilBeneficiario = perfilBeneficiarios[index];

    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);

    final nombreCompleto =
        '${perfilBeneficiario.nombre1} ${perfilBeneficiario.nombre2 ?? ''} ${perfilBeneficiario.apellido1} ${perfilBeneficiario.apellido2 ?? ''}';

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilBeneficiario.beneficiarioId!)),
        DataCell(TextButton(
            onPressed: () {
              perfilBeneficiarioCubit.setPerfilBeneficiario(perfilBeneficiario);

              Navigator.pushNamed(
                context,
                'NewEditVPerfilBeneficiario',
              );
            },
            child: Text(nombreCompleto)))

        // Add more cells for each column
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilBeneficiarios.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilBeneficiariosRows extends StatefulWidget {
  const PerfilBeneficiariosRows({
    Key? key,
    required this.perfilBeneficiarios,
  }) : super(key: key);

  final List<PerfilBeneficiarioEntity> perfilBeneficiarios;

  @override
  State<PerfilBeneficiariosRows> createState() =>
      _PerfilBeneficiariosRowsState();
}

class _PerfilBeneficiariosRowsState extends State<PerfilBeneficiariosRows> {
  List<PerfilBeneficiarioEntity> perfilBeneficiariosFiltered = [];

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilBeneficiarios =
        widget.perfilBeneficiarios.where((perfilBeneficiario) {
      final nombreCompleto =
          '${perfilBeneficiario.nombre1 ?? ''} ${perfilBeneficiario.nombre2 ?? ''} ${perfilBeneficiario.apellido1 ?? ''} ${perfilBeneficiario.apellido2 ?? ''}';

      return nombreCompleto.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilBeneficiariosFiltered = perfilBeneficiarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    perfilBeneficiariosFiltered = widget.perfilBeneficiarios;
    return widget.perfilBeneficiarios.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Beneficiarios',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'NewEditVPerfilBeneficiario');
                        },
                        icon: const Icon(
                          Icons.add,
                        ))
                  ],
                ),
              ),
              const Expanded(child: NoDataSvg(title: 'No hay resultados')),
            ],
          )
        : ListView(
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
                          Navigator.pushNamed(
                              context, 'NewEditVPerfilBeneficiario');
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
                source: PerfilBeneficiariosTableSource(
                    context, perfilBeneficiariosFiltered),
              ),
            ],
          );
  }
}
