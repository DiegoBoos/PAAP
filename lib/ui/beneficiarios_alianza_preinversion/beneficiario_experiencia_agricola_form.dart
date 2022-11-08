import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import 'package:paap/domain/entities/frecuencia_entity.dart';
import 'package:paap/domain/entities/tipo_actividad_productiva_entity.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../domain/cubits/frecuencia/frecuencia_cubit.dart';
import '../utils/input_decoration.dart';
import '../utils/styles.dart';

class BeneficiarioExperienciaAgricolaForm extends StatefulWidget {
  const BeneficiarioExperienciaAgricolaForm({super.key});

  @override
  State<BeneficiarioExperienciaAgricolaForm> createState() =>
      _BeneficiarioExperienciaAgricolaFormState();
}

class _BeneficiarioExperienciaAgricolaFormState
    extends State<BeneficiarioExperienciaAgricolaForm> {
  @override
  Widget build(BuildContext context) {
    final frecuenciaCubit = BlocProvider.of<FrecuenciaCubit>(context);
    final tipoActividadProductivaCubit =
        BlocProvider.of<TipoActividadProductivaCubit>(context);
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
                    'Información de Experiencia Agrícola',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      items: tipoActividadProductivaCubit
                          .state.tiposActividadesProductivas!
                          .map<DropdownMenuItem<String>>(
                              (TipoActividadProductivaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoActividadProductivaId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Tipo de Actividad Productiva')),
                  DropdownButtonFormField(
                      items: frecuenciaCubit.state.frecuencias!
                          .map<DropdownMenuItem<String>>(
                              (FrecuenciaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.frecuenciaId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Frecuencia')),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área del Cultivo hectárea',
                          labelText: 'Área del Cultivo hectárea')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cantidad Producida',
                          labelText: 'Cantidad Producida')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cantidad Vendida',
                          labelText: 'Cantidad Vendida')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cantidad Autoconsumo',
                          labelText: 'Cantidad Autoconsumo')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Costo de implementación',
                          labelText: 'Costo de implementación')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Valor Jornal', labelText: 'Valor Jornal')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ingreso Total Neto',
                          labelText: 'Ingreso Total Neto')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área de Pastos',
                          labelText: 'Área de Pastos')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área sin uso', labelText: 'Área sin uso')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área de Reserva',
                          labelText: 'Área de Reserva')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área Implementación',
                          labelText: 'Área Implementación')),
                  TextFormField(
                      initialValue: beneficiario.beneficiarioId,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Total Área Predio',
                          labelText: 'Total Área Predio')),

                  //TODO: falta si el proyecto es pecuario
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
