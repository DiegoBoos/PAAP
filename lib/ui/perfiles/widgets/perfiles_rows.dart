import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/v_perfil/v_perfil_cubit.dart';

import '../../../domain/entities/v_perfil_entity.dart';

class PerfilesRows extends StatelessWidget {
  const PerfilesRows({
    Key? key,
    required this.vPerfiles,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<VPerfilEntity> vPerfiles;
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
        rows: List.generate(vPerfiles.length, (index) {
          VPerfilEntity vPerfil = vPerfiles[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(vPerfil.perfilId)),
            DataCell(Text(vPerfil.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  BlocProvider.of<VPerfilCubit>(context).selectVPerfil(vPerfil);
                  Navigator.pushNamed(context, 'VPerfil');
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
