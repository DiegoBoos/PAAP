import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/v_perfil_entity.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';

class VPerfilesTableSource extends DataTableSource {
  final BuildContext context;
  final List<VPerfilEntity> vPerfiles;

  VPerfilesTableSource(this.context, this.vPerfiles);

  @override
  DataRow getRow(int index) {
    final vPerfil = vPerfiles[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(vPerfil.perfilId)),
        DataCell(TextButton(
          onPressed: () {
            BlocProvider.of<VPerfilCubit>(context).selectVPerfil(vPerfil);
            Navigator.pushNamed(context, 'VPerfil');
          },
          child: Text(
            vPerfil.nombre,
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => vPerfiles.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilesRows extends StatefulWidget {
  const PerfilesRows({
    Key? key,
    required this.vPerfiles,
  }) : super(key: key);

  final List<VPerfilEntity> vPerfiles;

  @override
  State<PerfilesRows> createState() => _PerfilesRowsState();
}

class _PerfilesRowsState extends State<PerfilesRows> {
  List<VPerfilEntity> vPerfilesFiltered = [];
  List<VPerfilEntity> allVPerfiles = [];

  bool enableId = false;

  @override
  void initState() {
    super.initState();
    allVPerfiles = widget.vPerfiles;
    vPerfilesFiltered = allVPerfiles;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();

    if (enableId) {
      final vperfiles = allVPerfiles.where((vperfil) {
        return vperfil.perfilId.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      setState(() {
        vPerfilesFiltered = vperfiles;
      });
      return;
    } else {
      final vperfiles = allVPerfiles.where((vperfil) {
        return vperfil.nombre.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      setState(() {
        vPerfilesFiltered = vperfiles;
      });
      return;
    }
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
          source: VPerfilesTableSource(context, vPerfilesFiltered),
        ),
      ],
    );
  }
}
