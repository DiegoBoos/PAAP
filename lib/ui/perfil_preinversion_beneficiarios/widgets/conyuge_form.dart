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
import '../../utils/custom_snack_bar.dart';
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
  final conyugeIdCtrl = TextEditingController();
  final conyugePrimerNombreCtrl = TextEditingController();
  final conyugePrimerApellidoCtrl = TextEditingController();
  final conyugeSegundoNombreCtrl = TextEditingController();
  final conyugeSegundoApellidoCtrl = TextEditingController();
  final ingresosMensualesCtrl = TextEditingController();

  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocListener<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(
      listener: (context, state) {
        BlocBuilder<PerfilPreInversionBeneficiarioCubit,
            PerfilPreInversionBeneficiarioState>(builder: (context, state) {
          if (state is PerfilPreInversionBeneficiarioError) {
            CustomSnackBar.showSnackBar(context, state.message, Colors.red);
          }
          if (state is PerfilPreInversionBeneficiarioLoaded) {
            final perfilPreInversionBeneficiarioLoaded =
                state.perfilPreInversionBeneficiarioLoaded!;

            fechaExpedicionCtrl.text = dateFormat.format(DateTime.parse(
                perfilPreInversionBeneficiarioLoaded
                    .conyugeFechaExpedicionDocumento));

            fechaNacimientoCtrl.text = dateFormat.format(DateTime.parse(
                perfilPreInversionBeneficiarioLoaded.conyugeFechaNacimiento));

            conyugePrimerNombreCtrl.text =
                perfilPreInversionBeneficiarioLoaded.conyugeNombre1;
            conyugePrimerApellidoCtrl.text =
                perfilPreInversionBeneficiarioLoaded.conyugeApellido1;

            conyugeSegundoNombreCtrl.text =
                perfilPreInversionBeneficiarioLoaded.conyugeNombre2;
            conyugeSegundoApellidoCtrl.text =
                perfilPreInversionBeneficiarioLoaded.conyugeApellido2;
          }

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
                    controller: conyugeIdCtrl,
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

                            fechaExpedicionCtrl.text =
                                dateFormat.format(newDate);

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
                          controller: conyugePrimerNombreCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Conyuge Nombre 1',
                              labelText: 'Conyuge Nombre 1'),
                          onSaved: (newValue) {
                            perfilPreInversionBeneficiarioCubit
                                .changeConyugeNombre1(newValue);
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          controller: conyugePrimerApellidoCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Conyuge Apellido 1',
                              labelText: 'Conyuge Apellido 1'),
                          onSaved: (newValue) {
                            perfilPreInversionBeneficiarioCubit
                                .changeConyugeApellido1(newValue);
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: conyugeSegundoNombreCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Conyuge Nombre 2',
                              labelText: 'Conyuge Nombre 2'),
                          onSaved: (newValue) {
                            perfilPreInversionBeneficiarioCubit
                                .changeConyugeNombre2(newValue);
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          controller: conyugeSegundoApellidoCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Conyuge Apellido 2',
                              labelText: 'Conyuge Apellido 2'),
                          onSaved: (newValue) {
                            perfilPreInversionBeneficiarioCubit
                                .changeConyugeApellido2(newValue);
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<GeneroCubit, GeneroState>(
                  builder: (context, state) {
                    if (state is GenerosLoaded) {
                      return DropdownButtonFormField(
                          items: state.generos!.map<DropdownMenuItem<String>>(
                              (GeneroEntity value) {
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

                            fechaNacimientoCtrl.text =
                                dateFormat.format(newDate);

                            perfilPreInversionBeneficiarioCubit
                                .changeConyugeFechaNacimiento(
                                    fechaNacimientoCtrl.text);
                          },
                          icon: const Icon(Icons.calendar_today))),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: ingresosMensualesCtrl,
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
                      child:
                          BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
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
      },
      child: Container(),
    );
  }
}
