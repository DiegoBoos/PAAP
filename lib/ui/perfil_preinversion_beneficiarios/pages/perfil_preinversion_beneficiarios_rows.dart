import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../utils/no_data_svg.dart';

class PerfilPreInversionBeneficiariosTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilPreInversionBeneficiarioEntity>
      perfilPreInversionBeneficiarios;

  PerfilPreInversionBeneficiariosTableSource(
      this.context, this.perfilPreInversionBeneficiarios);

  @override
  DataRow getRow(int index) {
    final perfilPreInversionBeneficiario =
        perfilPreInversionBeneficiarios[index];

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreinversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);

    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    final nombreCompleto =
        '${perfilPreInversionBeneficiario.nombre1 ?? ''} ${perfilPreInversionBeneficiario.nombre2 ?? ''} ${perfilPreInversionBeneficiario.apellido1 ?? ''} ${perfilPreInversionBeneficiario.apellido2 ?? ''}';

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilPreInversionBeneficiario.beneficiarioId!)),
        DataCell(TextButton(
          onPressed: () {
            final tipoProyecto = vPerfilPreInversionCubit
                .state.vPerfilPreInversion!.tipoProyecto;

            final beneficiarioId =
                perfilPreInversionBeneficiario.beneficiarioId!;

            perfilPreinversionBeneficiarioCubit
                .setPerfilPreInversionBeneficiario(
                    perfilPreInversionBeneficiario);

            if (tipoProyecto == 'Agrícola') {
              experienciaAgricolaCubit.loadExperienciaAgricola(
                  '1', beneficiarioId);
            } else if (tipoProyecto == 'Pecuario') {
              experienciaPecuariaCubit.loadExperienciaPecuaria(
                  '1', beneficiarioId);
            }

            Navigator.pushNamed(
              context,
              'NewEditVBeneficiarioPreInversion',
            );
          },
          child: SizedBox(
            width: 200,
            child: Text(nombreCompleto),
          ),
        )),

        // Add more cells for each column
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilPreInversionBeneficiarios.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilPreInversionBeneficiariosRows extends StatefulWidget {
  const PerfilPreInversionBeneficiariosRows({
    Key? key,
    required this.perfilPreInversionBeneficiarios,
  }) : super(key: key);

  final List<PerfilPreInversionBeneficiarioEntity>
      perfilPreInversionBeneficiarios;

  @override
  State<PerfilPreInversionBeneficiariosRows> createState() =>
      _PerfilPreInversionBeneficiariosRowsState();
}

class _PerfilPreInversionBeneficiariosRowsState
    extends State<PerfilPreInversionBeneficiariosRows> {
  List<PerfilPreInversionBeneficiarioEntity>
      perfilPreInversionBeneficiariosFiltered = [];

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilPreInversionBeneficiarios = widget
        .perfilPreInversionBeneficiarios
        .where((perfilPreInversionBeneficiario) {
      final nombreCompleto =
          '${perfilPreInversionBeneficiario.nombre1 ?? ''} ${perfilPreInversionBeneficiario.nombre2 ?? ''} ${perfilPreInversionBeneficiario.apellido1 ?? ''} ${perfilPreInversionBeneficiario.apellido2 ?? ''}';

      return nombreCompleto.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilPreInversionBeneficiariosFiltered = perfilPreInversionBeneficiarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    perfilPreInversionBeneficiariosFiltered =
        widget.perfilPreInversionBeneficiarios;
    return widget.perfilPreInversionBeneficiarios.isEmpty
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
                              context, 'NewEditVBeneficiarioPreInversion');
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
                dataRowHeight: 250,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Beneficiarios'),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'NewEditVBeneficiarioPreInversion');
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
                source: PerfilPreInversionBeneficiariosTableSource(
                    context, perfilPreInversionBeneficiariosFiltered),
              ),
            ],
          );
  }
}
