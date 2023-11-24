import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/beneficiario/beneficiario_cubit.dart';
import '../../cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';

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

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilPreInversionBeneficiario.beneficiarioId!)),
        DataCell(TextButton(
            onPressed: () {
              final vPerfilPreinversionCubit =
                  BlocProvider.of<VPerfilPreInversionCubit>(context);
              final beneficiarioCubit =
                  BlocProvider.of<BeneficiarioCubit>(context);
              final perfilPreInversionBeneficiarioCubit =
                  BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);
              final perfilBeneficiarioCubit =
                  BlocProvider.of<PerfilBeneficiarioCubit>(context);
              final experienciaAgricolaCubit =
                  BlocProvider.of<ExperienciaAgricolaCubit>(context);
              final experienciaPecuariaCubit =
                  BlocProvider.of<ExperienciaPecuariaCubit>(context);
              final tipoProyecto = vPerfilPreinversionCubit
                  .state.vPerfilPreInversion!.tipoProyecto;
              final perfilId =
                  vPerfilPreinversionCubit.state.vPerfilPreInversion!.perfilId!;

              final beneficiarioId =
                  perfilPreInversionBeneficiario.beneficiarioId;

              beneficiarioCubit.loadBeneficiario(beneficiarioId!);

              perfilBeneficiarioCubit.loadPerfilBeneficiario(
                  perfilId, beneficiarioId);

              if (tipoProyecto == 'Agrícola') {
                experienciaAgricolaCubit.loadExperienciaAgricola(
                    '1', beneficiarioId);
              } else if (tipoProyecto == 'Pecuario') {
                experienciaPecuariaCubit.loadExperienciaPecuaria(
                    '1', beneficiarioId);
              }

              perfilPreInversionBeneficiarioCubit
                  .setPerfilPreInversionBeneficiario(
                      perfilPreInversionBeneficiario);

              Navigator.pushNamed(
                context,
                'NewEditVBeneficiarioPreInversion',
              );
            },
            child: Text(perfilPreInversionBeneficiario.nombre ?? ''))),

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
  List<PerfilPreInversionBeneficiarioEntity>
      allPerfilPreInversionBeneficiarios = [];

  @override
  void initState() {
    super.initState();
    allPerfilPreInversionBeneficiarios = widget.perfilPreInversionBeneficiarios;
    perfilPreInversionBeneficiariosFiltered =
        allPerfilPreInversionBeneficiarios;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilPreInversionBeneficiarios = allPerfilPreInversionBeneficiarios
        .where((perfilPreInversionBeneficiario) {
      return perfilPreInversionBeneficiario.nombre!
          .toLowerCase()
          .contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilPreInversionBeneficiariosFiltered = perfilPreInversionBeneficiarios;
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
