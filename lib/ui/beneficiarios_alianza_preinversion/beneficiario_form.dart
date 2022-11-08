import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/genero/genero_cubit.dart';
import '../../../domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../domain/cubits/estado_civil/estado_civil_cubit.dart';
import '../../domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../domain/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import '../../domain/entities/estado_civil_entity.dart';
import '../../domain/entities/grupo_especial_entity.dart';
import '../../domain/entities/tipo_discapacidad_entity.dart';
import '../utils/floating_buttons.dart';
import '../utils/input_decoration.dart';
import '../utils/styles.dart';

class BeneficiarioForm extends StatefulWidget {
  const BeneficiarioForm({super.key});

  @override
  State<BeneficiarioForm> createState() => _BeneficiarioFormState();
}

class _BeneficiarioFormState extends State<BeneficiarioForm> {
  @override
  Widget build(BuildContext context) {
    final tipoIdentificacionCubit =
        BlocProvider.of<TipoIdentificacionCubit>(context);
    final generoCubit = BlocProvider.of<GeneroCubit>(context);
    final estadoCivilCubit = BlocProvider.of<EstadoCivilCubit>(context);
    final grupoEspecialCubit = BlocProvider.of<GrupoEspecialCubit>(context);
    final tipoDiscapacidadCubit =
        BlocProvider.of<TipoDiscapacidadCubit>(context);

    return BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
      builder: (context, state) {
        if (state is BeneficiarioLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is BeneficiarioLoaded) {
          final beneficiario = state.beneficiarioLoaded!;
          DateTime fechaExpedicion =
              DateTime.parse(beneficiario.fechaExpedicionDocumento);
          DateTime fechaNacimiento =
              DateTime.parse(beneficiario.fechaNacimiento);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Card(
              child: Column(children: [
                const Text(
                  'Información del beneficiario',
                  style: Styles.titleStyle,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    items: tipoIdentificacionCubit.state.tiposIdentificaciones!
                        .map<DropdownMenuItem<String>>(
                            (TipoIdentificacionEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.tipoIdentificacionId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Tipo de documento',
                        labelText: 'Tipo de documento')),
                const SizedBox(height: 20),
                TextFormField(
                    initialValue: beneficiario.beneficiarioId,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Documento de identificación',
                        labelText: 'Documento de identificación')),
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
                //TODO: calcular edad
                TextFormField(
                    initialValue: beneficiario.edad,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Edad', labelText: 'Edad')),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiario.nombre1,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Primer Nombre',
                              labelText: 'Primer Nombre')),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiario.nombre2,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Segundo Nombre',
                              labelText: 'Segundo Nombre')),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiario.apellido1,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Primer Apellido',
                              labelText: 'Primer Apellido')),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiario.apellido2,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Segundo Apellido',
                              labelText: 'Segundo Apellido')),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                          items: generoCubit.state.generos!
                              .map<DropdownMenuItem<String>>(
                                  (GeneroEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.generoId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {},
                          hint: const Text('Género')),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButtonFormField(
                          items: estadoCivilCubit.state.estadosCiviles!
                              .map<DropdownMenuItem<String>>(
                                  (EstadoCivilEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.estadoCivilId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {},
                          hint: const Text('Estado Civil')),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButtonFormField(
                          items: tipoDiscapacidadCubit
                              .state.tiposDiscapacidades!
                              .map<DropdownMenuItem<String>>(
                                  (TipoDiscapacidadEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.tipoDiscapacidadId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {},
                          hint: const Text('Discapacidad')),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiarioPreinversion.puntajeSisben,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Puntaje Sisben',
                              labelText: 'Puntaje Sisben')),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          initialValue: beneficiario.telefonoMovil,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Teléfono', labelText: 'Teléfono')),
                    ),
                    const SizedBox(width: 20),
                    const SaveBackButtons(onSaved: null)
                  ],
                )
              ]),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
