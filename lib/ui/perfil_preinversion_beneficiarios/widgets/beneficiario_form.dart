import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/estado_civil/estado_civil_cubit.dart';
import '../../../domain/cubits/genero/genero_cubit.dart';
import '../../../domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import '../../../domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/entities/estado_civil_entity.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioForm extends StatefulWidget {
  const BeneficiarioForm({super.key});

  @override
  State<BeneficiarioForm> createState() => _BeneficiarioFormState();
}

class _BeneficiarioFormState extends State<BeneficiarioForm> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BeneficiarioCubit>(context).initState();
  }

  final fechaExpedicionCtrl = TextEditingController();
  final fechaNacimientoCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);

    return BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
        builder: (context, state) {
      final beneficiario = state.beneficiario;

      fechaExpedicionCtrl.text = beneficiario?.fechaExpedicionDocumento != null
          ? beneficiario!.fechaExpedicionDocumento
          : dateFormat.format(DateTime.now());

      fechaNacimientoCtrl.text = beneficiario?.fechaNacimiento != null
          ? beneficiario!.fechaNacimiento
          : dateFormat.format(DateTime.now());

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              'Información del beneficiario',
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
                        beneficiarioCubit.changeTipoDocumento(value!);
                      },
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Tipo de documento',
                          labelText: 'Tipo de documento'));
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),

            //TODO: No existe campo documento
            TextFormField(
                initialValue: beneficiario?.beneficiarioId,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Documento de identificación',
                    labelText: 'Documento de identificación')),
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

                        beneficiarioCubit
                            .changeFechaExpedicion(fechaExpedicionCtrl.text);
                      },
                      icon: const Icon(Icons.calendar_today))),
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
                        beneficiarioCubit
                            .changeFechaNacimiento(fechaNacimientoCtrl.text);

                        DateTime edadDt =
                            DateTime.parse(fechaNacimientoCtrl.text);

                        var currentYear = DateTime.now().year;
                        var edad = currentYear - edadDt.year;
                        edadCtrl.text = edad.toString();
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: edadCtrl,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Edad', labelText: 'Edad')),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      initialValue: beneficiario?.nombre1,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Primer Nombre',
                          labelText: 'Primer Nombre'),
                      onSaved: (newValue) {
                        beneficiarioCubit.changePrimerNombre(newValue!);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue: beneficiario?.nombre2,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Segundo Nombre',
                          labelText: 'Segundo Nombre'),
                      onSaved: (newValue) {
                        beneficiarioCubit.changeSegundoNombre(newValue!);
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
                      initialValue: beneficiario?.apellido1,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Primer Apellido',
                          labelText: 'Primer Apellido'),
                      onSaved: (newValue) {
                        beneficiarioCubit.changePrimerApellido(newValue!);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue: beneficiario?.apellido2,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Segundo Apellido',
                          labelText: 'Segundo Apellido'),
                      onSaved: (newValue) {
                        beneficiarioCubit.changeSegundoApellido(newValue!);
                      }),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: BlocBuilder<GeneroCubit, GeneroState>(
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
                              beneficiarioCubit.changeGenero(value!);
                            },
                            hint: const Text('Género'));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(width: 20),

                //TODO: No existe campo estadoCivilId
                Expanded(
                  child: BlocBuilder<EstadoCivilCubit, EstadoCivilState>(
                    builder: (context, state) {
                      if (state is EstadosCivilesLoaded) {
                        return DropdownButtonFormField(
                            items: state.estadosCiviles!
                                .map<DropdownMenuItem<String>>(
                                    (EstadoCivilEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.estadoCivilId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              //beneficiarioCubit.changeEstadoCivil(value!);
                            },
                            hint: const Text('Estado Civil'));
                      }
                      return const SizedBox();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
                    builder: (context, state) {
                      if (state is EstadosCivilesLoaded) {
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
                              beneficiarioCubit.changeGrupoEspecial(value!);
                            },
                            hint: const Text('Grupo Especial'));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(width: 20),

                //TODO: No existe campo tipoDiscapacidadId
                Expanded(
                  child:
                      BlocBuilder<TipoDiscapacidadCubit, TipoDiscapacidadState>(
                    builder: (context, state) {
                      if (state is EstadosCivilesLoaded) {
                        return DropdownButtonFormField(
                            items: state.tiposDiscapacidades!
                                .map<DropdownMenuItem<String>>(
                                    (TipoDiscapacidadEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.tipoDiscapacidadId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              //beneficiarioCubit.changeDiscapacidad(value!);
                            },
                            hint: const Text('Discapacidad'));
                      }
                      return const SizedBox();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            //TODO: No existe campo puntajeSisbenId
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<PerfilPreInversionBeneficiarioCubit,
                    PerfilPreInversionBeneficiarioState>(
                  builder: (context, state) {
                    return Expanded(
                      child: TextFormField(
                          initialValue: state.perfilPreInversionBeneficiario
                                  ?.calificacionSisben ??
                              '',
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Puntaje Sisben',
                              labelText: 'Puntaje Sisben'),
                          onSaved: (newValue) {
                            /*  beneficiarioPreInversionCubit
                                .changeCalificacionSisben(newValue!); */
                          }),
                    );
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    initialValue: beneficiario?.telefonoMovil,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Teléfono', labelText: 'Teléfono'),
                    onSaved: ((newValue) {
                      beneficiarioCubit.changeTelefonoMovil(newValue!);
                    }),
                  ),
                ),
              ],
            )
          ]),
        ),
      );
    });
  }
}
