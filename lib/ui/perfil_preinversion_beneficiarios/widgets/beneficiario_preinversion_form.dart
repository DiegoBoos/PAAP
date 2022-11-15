import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/actividad_economica/actividad_economica_cubit.dart';
import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import '../../../domain/cubits/residencia/residencia_cubit.dart';
import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/entities/residencia_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilPreInversionBeneficiarioForm extends StatefulWidget {
  const PerfilPreInversionBeneficiarioForm({super.key});

  @override
  State<PerfilPreInversionBeneficiarioForm> createState() =>
      _PerfilPreInversionBeneficiarioFormState();
}

class _PerfilPreInversionBeneficiarioFormState
    extends State<PerfilPreInversionBeneficiarioForm> {
  @override
  Widget build(BuildContext context) {
    final residenciaCubit = BlocProvider.of<ResidenciaCubit>(context);
    final nivelEscolarCubit = BlocProvider.of<NivelEscolarCubit>(context);
    final actividadEconomicaCubit =
        BlocProvider.of<ActividadEconomicaCubit>(context);
    return BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
      builder: (context, state) {
        if (state is BeneficiarioLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is BeneficiarioLoaded) {
          final beneficiario = state.beneficiarioLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Card(
              child: Column(
                children: [
                  const Text(
                    'Información del Beneficiario con Relación a la PreInversión',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      items: residenciaCubit.state.residencias!
                          .map<DropdownMenuItem<String>>(
                              (ResidenciaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.residenciaId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Residencia')),
                  DropdownButtonFormField(
                      items: nivelEscolarCubit.state.nivelesEscolares!
                          .map<DropdownMenuItem<String>>(
                              (NivelEscolarEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.nivelEscolarId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Nivel Escolar')),
                  DropdownButtonFormField(
                      items: actividadEconomicaCubit
                          .state.actividadesEconomicas!
                          .map<DropdownMenuItem<String>>(
                              (ActividadEconomicaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.actividadEconomicaId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Actividad Económica')),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ingresos Diarios',
                          labelText: 'Ingresos Diarios')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Días Trabajados/mes',
                          labelText: 'Días Trabajados/mes')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Miembros del hogar',
                          labelText: 'Miembros del hogar')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'No Miembros Economicamente Activos',
                          labelText: 'No Miembros Economicamente Activos')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ingresos Mensuales',
                          labelText: 'Ingresos Mensuales')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Gastos Mensuales',
                          labelText: 'Gastos Mensuales')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Activo Inmobiliario',
                          labelText: 'Activo Inmobiliario')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Activo Financiero',
                          labelText: 'Activo Financiero')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Activo Productivo',
                          labelText: 'Activo Productivo')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Activo Corriente',
                          labelText: 'Activo Corriente')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Total Activo', labelText: 'Total Activo')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nombre Finca', labelText: 'Nombre Finca')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nombre de la Organizacion',
                          labelText: 'Nombre de la Organizacion')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Meses en la Asociación',
                          labelText: 'Meses en la Asociación')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nota', labelText: 'Nota')),
                  const SizedBox(height: 20),
                  SwitchListTile(
                      title: const Text('Acceso Explotación Tierra'),
                      value: false,
                      onChanged: (value) {}),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
