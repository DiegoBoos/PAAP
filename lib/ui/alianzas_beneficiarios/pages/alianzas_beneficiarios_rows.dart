import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../cubits/beneficiario/beneficiario_cubit.dart';
import '../../cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';

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

    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);

    final experienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);

    final experienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

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

              beneficiarioCubit.loadBeneficiario(beneficiarioId);

              if (tipoProyecto == 'Agrícola') {
                experienciaAgricolaCubit.selectAlianzaExperienciaAgricola(
                    '1', beneficiarioId);
              } else if (tipoProyecto == 'Pecuario') {
                experienciaPecuariaCubit.selectAlianzaExperienciaPecuaria(
                    '1', beneficiarioId);
              }

              Navigator.pushNamed(
                context,
                'NewEditVBeneficiarioAlianza',
              );
            },
            child: Text(alianzaBeneficiario.nombre ?? ''))),
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
  List<AlianzaBeneficiarioEntity> allAlianzasBeneficiarios = [];

  @override
  void initState() {
    super.initState();
    allAlianzasBeneficiarios = widget.alianzasBeneficiarios;
    alianzasBeneficiariosFiltered = allAlianzasBeneficiarios;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final alianzasBeneficiarios =
        allAlianzasBeneficiarios.where((alianzaBeneficiario) {
      return alianzaBeneficiario.nombre!.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      alianzasBeneficiariosFiltered = alianzasBeneficiarios;
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
              const Text('AlianzasBeneficiarios'),
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
