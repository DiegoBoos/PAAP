import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/beneficiario_preinversion/beneficiario_preinversion_cubit.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioPerfilForm extends StatefulWidget {
  const BeneficiarioPerfilForm({super.key});

  @override
  State<BeneficiarioPerfilForm> createState() => _BeneficiarioPerfilFormState();
}

class _BeneficiarioPerfilFormState extends State<BeneficiarioPerfilForm> {
  @override
  Widget build(BuildContext context) {
    final departamentoCubit = BlocProvider.of<DepartamentoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final tipoTenenciaCubit = BlocProvider.of<TipoTenenciaCubit>(context);
    return BlocBuilder<BeneficiarioPreinversionCubit,
        BeneficiarioPreinversionState>(
      builder: (context, state) {
        if (state is BeneficiarioPreinversionLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is BeneficiarioPreinversionLoaded) {
          final beneficiarioPreinversion =
              state.beneficiarioPreinversionLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Card(
              child: Column(
                children: [
                  const Text(
                    'Información del beneficiario con relación al perfil',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      items: departamentoCubit.state.departamentos!
                          .map<DropdownMenuItem<String>>(
                              (DepartamentoEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Departamento')),
                  DropdownButtonFormField(
                      items: municipioCubit.state.municipios!
                          .map<DropdownMenuItem<String>>(
                              (MunicipioEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Municipio')),
                  DropdownButtonFormField(
                      items: tipoTenenciaCubit.state.tiposTenencias!
                          .map<DropdownMenuItem<String>>(
                              (TipoTenenciaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoTenenciaId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Tipo de tenencia')),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: beneficiarioPreinversion.latitud,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ubicación - Latitud',
                          labelText: 'Ubicación - Latitud')),
                  TextFormField(
                      initialValue: beneficiarioPreinversion.longitud,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ubicación Longitud',
                          labelText: 'Ubicación Longitud')),
                  const SizedBox(height: 20),
                  SwitchListTile(
                      title: const Text('Cotiza BEPS'),
                      value: beneficiarioPreinversion.cotizanteBeps == 'true'
                          ? true
                          : false,
                      onChanged: (value) {}),
                  SwitchListTile(
                      title: const Text('Es asociado'),
                      value: beneficiarioPreinversion.asociado == 'true'
                          ? true
                          : false,
                      onChanged: (value) {}),
                  SwitchListTile(
                      title: const Text('Está activo en la alianza'),
                      value: beneficiarioPreinversion.activo == 'true'
                          ? true
                          : false,
                      onChanged: (value) {})
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
