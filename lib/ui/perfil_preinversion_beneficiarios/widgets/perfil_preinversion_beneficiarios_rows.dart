import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../domain/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';

class PerfilPreInversionBeneficiariosRows extends StatelessWidget {
  const PerfilPreInversionBeneficiariosRows({
    Key? key,
    required this.perfilPreInversionBeneficiarios,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilPreInversionBeneficiarioEntity>
      perfilPreInversionBeneficiarios;

  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final vPerfilPreinversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreinversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
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
        rows: List.generate(perfilPreInversionBeneficiarios.length, (index) {
          PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario =
              perfilPreInversionBeneficiarios[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(perfilPreInversionBeneficiario.beneficiarioId)),
            DataCell(Text(perfilPreInversionBeneficiario.nombreOrganizacion)),
            DataCell(IconButton(
                onPressed: () {
                  final perfilId = vPerfilPreinversionCubit
                      .state.vPerfilPreInversion!.perfilId;

                  final beneficiarioId =
                      perfilPreInversionBeneficiario.beneficiarioId;
                  final tipoActividadProductivaAgricolaId =
                      experienciaAgricolaCubit
                          .state.experienciaAgricola.tipoActividadProductivaId;
                  final tipoActividadProductivaPecuariaId =
                      experienciaPecuariaCubit
                          .state.experienciaPecuaria.tipoActividadProductivaId;

                  perfilPreinversionBeneficiarioCubit
                      .selectPerfilPreinversionBeneficiario(
                          perfilPreInversionBeneficiario);

                  beneficiarioCubit.loadBeneficiario(beneficiarioId);

                  perfilBeneficiarioCubit.selectPerfilBeneficiario(
                      perfilId, beneficiarioId);

                  experienciaAgricolaCubit.selectExperienciaAgricola(
                      tipoActividadProductivaAgricolaId, beneficiarioId);

                  experienciaPecuariaCubit.selectExperienciaPecuaria(
                      tipoActividadProductivaPecuariaId, beneficiarioId);

                  Navigator.pushNamed(
                      context, 'NewEditVBeneficiarioPreInversion');
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
