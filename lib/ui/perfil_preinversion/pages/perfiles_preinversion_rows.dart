import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';

class VPerfilesPreInversionTableSource extends DataTableSource {
  final BuildContext context;
  final List<VPerfilPreInversionEntity> vPerfilesPreInversion;

  VPerfilesPreInversionTableSource(this.context, this.vPerfilesPreInversion);

  @override
  DataRow getRow(int index) {
    final vPerfilPreInversion = vPerfilesPreInversion[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(vPerfilPreInversion.perfilPreInversionId!)),
        DataCell(TextButton(
          onPressed: () {
            BlocProvider.of<VPerfilPreInversionCubit>(context)
                .selectVPerfilPreinversion(vPerfilPreInversion);
            Navigator.pushNamed(
              context,
              'VPerfilPreInversion',
            );
          },
          child: SizedBox(
            width: 200,
            child: Text(
              vPerfilPreInversion.nombre!,
            ),
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => vPerfilesPreInversion.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilesPreInversionRows extends StatefulWidget {
  const PerfilesPreInversionRows({
    Key? key,
    required this.vPerfilesPreInversion,
  }) : super(key: key);

  final List<VPerfilPreInversionEntity> vPerfilesPreInversion;

  @override
  State<PerfilesPreInversionRows> createState() =>
      _PerfilesPreInversionRowsState();
}

class _PerfilesPreInversionRowsState extends State<PerfilesPreInversionRows> {
  List<VPerfilPreInversionEntity> vPerfilesPreInversionFiltered = [];
  List<VPerfilPreInversionEntity> allVPerfilesPreInversion = [];

  bool enableId = false;

  @override
  void initState() {
    super.initState();
    allVPerfilesPreInversion = widget.vPerfilesPreInversion;
    vPerfilesPreInversionFiltered = allVPerfilesPreInversion;
  }

  void _buscar(String query) {
    setState(() {
      if (query.isEmpty) {
        vPerfilesPreInversionFiltered = allVPerfilesPreInversion;
      } else {
        final lowerCaseQuery = query.toLowerCase();
        if (enableId) {
          final vPerfilesPreInversion =
              allVPerfilesPreInversion.where((vPerfil) {
            return vPerfil.perfilPreInversionId!.toLowerCase() ==
                lowerCaseQuery;
          }).toList();

          vPerfilesPreInversionFiltered = vPerfilesPreInversion;
          return;
        } else {
          final vPerfilesPreInversion =
              allVPerfilesPreInversion.where((vPerfil) {
            return vPerfil.nombre!.toLowerCase().contains(lowerCaseQuery);
          }).toList();

          vPerfilesPreInversionFiltered = vPerfilesPreInversion;
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          onChanged: (value) => _buscar(value),
          decoration: InputDecoration(
            labelText: enableId ? 'Buscar por id' : 'Buscar por nombre',
            suffixIcon: const Icon(Icons.search),
          ),
        ),
        PaginatedDataTable(
          dataRowHeight: 250,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Perfiles'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      enableId = !enableId;
                    });
                  },
                  icon: const Icon(Icons.filter_alt))
            ],
          ),
          rowsPerPage: 10, // Adjust as needed
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
          ],
          source: VPerfilesPreInversionTableSource(
              context, vPerfilesPreInversionFiltered),
        ),
      ],
    );
  }
}
