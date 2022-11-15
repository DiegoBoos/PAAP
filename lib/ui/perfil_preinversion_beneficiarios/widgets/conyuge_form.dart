import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/genero/genero_cubit.dart';
import '../../../domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ConyugeForm extends StatefulWidget {
  const ConyugeForm({super.key});

  @override
  State<ConyugeForm> createState() => _ConyugeFormState();
}

class _ConyugeFormState extends State<ConyugeForm> {
  @override
  Widget build(BuildContext context) {
    final tipoIdentificacionCubit =
        BlocProvider.of<TipoIdentificacionCubit>(context);
    final generoCubit = BlocProvider.of<GeneroCubit>(context);
    final grupoEspecialCubit = BlocProvider.of<GrupoEspecialCubit>(context);

    return BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(
      builder: (context, state) {
        if (state is PerfilPreInversionBeneficiarioLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is PerfilPreInversionBeneficiarioLoaded) {
          final perfilPreInversionBeneficiario =
              state.perfilPreInversionBeneficiarioLoaded!;
          DateTime fechaExpedicion = DateTime.parse(
              perfilPreInversionBeneficiario.conyugeFechaExpedicionDocumento);
          DateTime fechaNacimiento = DateTime.parse(
              perfilPreInversionBeneficiario.conyugeFechaNacimiento);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Card(
              child: Column(
                children: [
                  const Text(
                    'Información del conyuge',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      items: tipoIdentificacionCubit
                          .state.tiposIdentificaciones!
                          .map<DropdownMenuItem<String>>(
                              (TipoIdentificacionEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoIdentificacionId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Tipo de documento cónyuge',
                          labelText: 'Tipo de documento cónyuge')),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Fecha de expedición',
                        labelText: 'Fecha de expedición',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: fechaExpedicion,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050));

                              if (newDate == null) return;

                              setState(() => fechaExpedicion = newDate);
                            },
                            icon: const Icon(Icons.calendar_today))),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            initialValue:
                                perfilPreInversionBeneficiario.conyugeNombre,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Nombre', labelText: 'Nombre')),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            initialValue:
                                perfilPreInversionBeneficiario.conyugeApellido,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Apellido', labelText: 'Apellido')),
                      )
                    ],
                  ),
                  DropdownButtonFormField(
                      items: generoCubit.state.generos!
                          .map<DropdownMenuItem<String>>((GeneroEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.generoId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      hint: const Text('Género')),
                  TextFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Fecha de nacimiento',
                        labelText: 'Fecha de nacimiento',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: fechaNacimiento,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050));

                              if (newDate == null) return;

                              setState(() => fechaNacimiento = newDate);
                            },
                            icon: const Icon(Icons.calendar_today))),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            initialValue: perfilPreInversionBeneficiario
                                .ingresosMensuales,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Ingresos Mensuales',
                                labelText: 'Ingresos Mensuales')),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField(
                            items: grupoEspecialCubit.state.gruposEspeciales!
                                .map<DropdownMenuItem<String>>(
                                    (GrupoEspecialEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.grupoEspecialId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            hint: const Text('Grupo Especial')),
                      )
                    ],
                  ),
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
