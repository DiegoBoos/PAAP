import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  final fechaNacimientoCtrl = TextEditingController();
  final fechaExpedicionCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(builder: (context, state) {
      final perfilPreInversionBeneficiario =
          state.perfilPreInversionBeneficiario;

      fechaExpedicionCtrl.text =
          perfilPreInversionBeneficiario?.conyugeFechaExpedicionDocumento !=
                  null
              ? perfilPreInversionBeneficiario!.conyugeFechaExpedicionDocumento
              : dateFormat.format(DateTime.now());

      fechaNacimientoCtrl.text =
          perfilPreInversionBeneficiario?.conyugeFechaNacimiento != null
              ? perfilPreInversionBeneficiario!.conyugeFechaNacimiento
              : dateFormat.format(DateTime.now());

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              'Información del conyuge',
              style: Styles.titleStyle,
            ),
            const SizedBox(height: 20),
            BlocBuilder<TipoIdentificacionCubit, TipoIdentificacionState>(
              builder: (context, state) {
                if (state is TiposIdentificacionesLoaded) {
                  return DropdownButtonFormField(
                      items: state.tiposIdentificaciones!
                          .map<DropdownMenuItem<String>>(
                              (TipoIdentificacionEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoIdentificacionId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeTipoIdentificacion(value);
                      },
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Tipo de documento',
                          labelText: 'Tipo de documento'));
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: perfilPreInversionBeneficiario?.conyugeId,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Documento de identificación',
                    labelText: 'Documento de identificación'),
                onSaved: (newValue) {
                  perfilPreInversionBeneficiarioCubit
                      .changeConyugeDocumento(newValue);
                }),
            const SizedBox(height: 20),
            TextFormField(
              controller: fechaExpedicionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Fecha de expedición',
                  labelText: 'Fecha de expedición',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        fechaExpedicionCtrl.text = dateFormat.format(newDate);

                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeFechaExpedicion(
                                fechaExpedicionCtrl.text);
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
                          perfilPreInversionBeneficiario?.conyugeNombre,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nombre', labelText: 'Nombre'),
                      onSaved: (newValue) {
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeNombre(newValue);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue:
                          perfilPreInversionBeneficiario?.conyugeApellido,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Apellido', labelText: 'Apellido'),
                      onSaved: (newValue) {
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeApellido(newValue);
                      }),
                )
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<GeneroCubit, GeneroState>(
              builder: (context, state) {
                if (state is GenerosLoaded) {
                  return DropdownButtonFormField(
                      items: state.generos!
                          .map<DropdownMenuItem<String>>((GeneroEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.generoId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeGenero(value);
                      },
                      hint: const Text('Género'));
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: fechaNacimientoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Fecha de nacimiento',
                  labelText: 'Fecha de nacimiento',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        fechaNacimientoCtrl.text = dateFormat.format(newDate);
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeFechaNacimiento(
                                fechaNacimientoCtrl.text);

                        DateTime edadDt =
                            DateTime.parse(fechaNacimientoCtrl.text);

                        var currentYear = DateTime.now().year;
                        var edad = currentYear - edadDt.year;
                        edadCtrl.text = edad.toString();
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
                          perfilPreInversionBeneficiario?.ingresosMensuales,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Ingresos Mensuales',
                          labelText: 'Ingresos Mensuales'),
                      onSaved: (newValue) {
                        perfilPreInversionBeneficiarioCubit
                            .changeIngresosMensuales(newValue);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
                    builder: (context, state) {
                      if (state is GruposEspecialesLoaded) {
                        return DropdownButtonFormField(
                            items: state.gruposEspeciales!
                                .map<DropdownMenuItem<String>>(
                                    (GrupoEspecialEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.grupoEspecialId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              perfilPreInversionBeneficiarioCubit
                                  .changeConyugeGrupoEspecial(value);
                            },
                            hint: const Text('Grupo Especial'));
                      }
                      return const SizedBox();
                    },
                  ),
                )
              ],
            ),
          ]),
        ),
      );
    });
  }
}
