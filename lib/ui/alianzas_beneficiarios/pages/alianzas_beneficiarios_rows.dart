import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../utils/no_data_svg.dart';

class AlianzasBeneficiariosTableSource extends DataTableSource {
  final BuildContext context;
  final List<AlianzaBeneficiarioEntity> alianzasBeneficiarios;

  AlianzasBeneficiariosTableSource(this.context, this.alianzasBeneficiarios);

  @override
  DataRow getRow(int index) {
    final alianzaBeneficiario = alianzasBeneficiarios[index];

    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);

    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);

    final experienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);

    final experienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    final nombreCompleto =
        '${alianzaBeneficiario.nombre1 ?? ''} ${alianzaBeneficiario.nombre2 ?? ''} ${alianzaBeneficiario.apellido1 ?? ''} ${alianzaBeneficiario.apellido2 ?? ''}';

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(alianzaBeneficiario.alianzaId!)),
        DataCell(TextButton(
            onPressed: () {
              final tipoProyecto = vAlianzaCubit.state.vAlianza!.tipoProyecto;

              final beneficiarioId = alianzaBeneficiario.beneficiarioId!;

              alianzaBeneficiarioCubit
                  .setAlianzaBeneficiario(alianzaBeneficiario);

              if (tipoProyecto == 'Agrícola') {
                experienciaAgricolaCubit.loadAlianzaExperienciaAgricola(
                    '1', beneficiarioId);
              } else if (tipoProyecto == 'Pecuario') {
                experienciaPecuariaCubit.loadAlianzaExperienciaPecuaria(
                    '1', beneficiarioId);
              }

              Navigator.pushNamed(
                context,
                'NewEditVBeneficiarioAlianza',
              );
            },
            child: Text(nombreCompleto))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => alianzasBeneficiarios.length;

  @override
  int get selectedRowCount => 0;
}

class AlianzasBeneficiariosRows extends StatefulWidget {
  const AlianzasBeneficiariosRows({
    Key? key,
    required this.alianzasBeneficiarios,
  }) : super(key: key);

  final List<AlianzaBeneficiarioEntity> alianzasBeneficiarios;

  @override
  State<AlianzasBeneficiariosRows> createState() =>
      _AlianzasBeneficiariosRowsState();
}

class _AlianzasBeneficiariosRowsState extends State<AlianzasBeneficiariosRows> {
  List<AlianzaBeneficiarioEntity> alianzasBeneficiariosFiltered = [];

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final alianzasBeneficiarios =
        widget.alianzasBeneficiarios.where((alianzaBeneficiario) {
      final nombreCompleto =
          '${alianzaBeneficiario.nombre1 ?? ''} ${alianzaBeneficiario.nombre2 ?? ''} ${alianzaBeneficiario.apellido1 ?? ''} ${alianzaBeneficiario.apellido2 ?? ''}';
      return nombreCompleto.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      alianzasBeneficiariosFiltered = alianzasBeneficiarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    alianzasBeneficiariosFiltered = widget.alianzasBeneficiarios;
    return widget.alianzasBeneficiarios.isEmpty
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
                              context, 'NewEditVBeneficiarioAlianza');
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
                        onPressed: () => Navigator.pushNamed(
                            context, 'NewEditVBeneficiarioAlianza'),
                        icon: const Icon(Icons.add))
                  ],
                ),
                rowsPerPage: 10, // Adjust as needed
                columns: const <DataColumn>[
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                ],
                source: AlianzasBeneficiariosTableSource(
                    context, alianzasBeneficiariosFiltered),
              ),
            ],
          );
  }
}
