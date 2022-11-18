import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paap/ui/utils/custom_snack_bar.dart';

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
  final primerNombreCtrl = TextEditingController();
  final primerApellidoCtrl = TextEditingController();
  final segundoNombreCtrl = TextEditingController();
  final segundoApellidoCtrl = TextEditingController();
  final telefonoMovilCtrl = TextEditingController();
  final calificacionSisbenCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<BeneficiarioCubit, BeneficiarioState>(
            listener: (context, state) {
              if (state is BeneficiarioError) {
                CustomSnackBar.showSnackBar(context, state.message, Colors.red);
              }
              if (state is BeneficiarioLoaded) {
                final beneficiarioLoaded = state.beneficiarioLoaded!;

                fechaExpedicionCtrl.text = dateFormat.format(DateTime.parse(
                    beneficiarioLoaded.fechaExpedicionDocumento));

                fechaNacimientoCtrl.text = dateFormat
                    .format(DateTime.parse(beneficiarioLoaded.fechaNacimiento));

                calcularEdad(fechaNacimientoCtrl.text);

                primerNombreCtrl.text = beneficiarioLoaded.nombre1;
                segundoNombreCtrl.text = beneficiarioLoaded.nombre2;
                primerApellidoCtrl.text = beneficiarioLoaded.apellido1;
                segundoApellidoCtrl.text = beneficiarioLoaded.apellido2;
                telefonoMovilCtrl.text = beneficiarioLoaded.telefonoMovil;
              }
            },
          ),
          BlocListener<PerfilPreInversionBeneficiarioCubit,
              PerfilPreInversionBeneficiarioState>(
            listener: (context, state) {
              if (state is PerfilPreInversionBeneficiarioError) {
                CustomSnackBar.showSnackBar(context, state.message, Colors.red);
              }
              if (state is PerfilPreInversionBeneficiarioLoaded) {
                final perfilPreInversionBeneficiarioLoaded =
                    state.perfilPreInversionBeneficiarioLoaded!;

                calificacionSisbenCtrl.text =
                    perfilPreInversionBeneficiarioLoaded.calificacionSisben;
              }
            },
          )
        ],
        child: BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
            builder: (context, state) {
          final beneficiario = state.beneficiario;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                const Text(
                  'Información del beneficiario',
                  style: Styles.titleStyle,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Documento de identificación',
                      labelText: 'Documento de identificación'),
                  onFieldSubmitted: (String value) {
                    beneficiarioCubit.selectBeneficiario(value);
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<TipoIdentificacionCubit, TipoIdentificacionState>(
                  builder: (context, state) {
                    if (state is TiposIdentificacionesLoaded) {
                      return DropdownButtonFormField(
                          value: beneficiario?.tipoIdentificacionId != ''
                              ? beneficiario?.tipoIdentificacionId
                              : null,
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
                TextFormField(
                  controller: fechaExpedicionCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Fecha de expedición',
                      labelText: 'Fecha de expedición',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: fechaExpedicionCtrl.text != ''
                                    ? DateTime.parse(fechaExpedicionCtrl.text)
                                    : DateTime.now(),
                                firstDate: DateTime(1000),
                                lastDate: DateTime(3000));

                            if (newDate == null) return;

                            fechaExpedicionCtrl.text =
                                dateFormat.format(newDate);

                            beneficiarioCubit.changeFechaExpedicion(
                                fechaExpedicionCtrl.text);
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
                                initialDate: fechaNacimientoCtrl.text != ''
                                    ? DateTime.parse(fechaNacimientoCtrl.text)
                                    : DateTime.now(),
                                firstDate: DateTime(1000),
                                lastDate: DateTime(3000));

                            if (newDate == null) return;

                            fechaNacimientoCtrl.text =
                                dateFormat.format(newDate);

                            beneficiarioCubit.changeFechaNacimiento(
                                fechaNacimientoCtrl.text);

                            calcularEdad(fechaNacimientoCtrl.text);
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
                          controller: primerNombreCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Primer Nombre',
                              labelText: 'Primer Nombre'),
                          onSaved: (String? newValue) {
                            beneficiarioCubit.changePrimerNombre(newValue);
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          controller: segundoNombreCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Segundo Nombre',
                              labelText: 'Segundo Nombre'),
                          onSaved: (String? newValue) {
                            beneficiarioCubit.changeSegundoNombre(newValue);
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
                          controller: primerApellidoCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Primer Apellido',
                              labelText: 'Primer Apellido'),
                          onSaved: (String? newValue) {
                            beneficiarioCubit.changePrimerApellido(newValue);
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                          controller: segundoApellidoCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Segundo Apellido',
                              labelText: 'Segundo Apellido'),
                          onSaved: (String? newValue) {
                            beneficiarioCubit.changeSegundoApellido(newValue);
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
                                value: beneficiario?.generoId != ''
                                    ? beneficiario?.generoId
                                    : null,
                                items: state.generos!
                                    .map<DropdownMenuItem<String>>(
                                        (GeneroEntity value) {
                                  return DropdownMenuItem<String>(
                                    value: value.generoId,
                                    child: Text(value.nombre),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  beneficiarioCubit.changeGenero(value);
                                },
                                hint: const Text('Género'));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
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
                                  perfilPreInversionBeneficiarioCubit
                                      .changeEstadoCivil(value);
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
                      child:
                          BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
                        builder: (context, state) {
                          if (state is GruposEspecialesLoaded) {
                            return DropdownButtonFormField(
                                value: beneficiario?.grupoEspecialId != ''
                                    ? beneficiario?.grupoEspecialId
                                    : null,
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
                    Expanded(
                      child: TextFormField(
                        controller: telefonoMovilCtrl,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono', labelText: 'Teléfono'),
                        onSaved: ((newValue) {
                          beneficiarioCubit.changeTelefonoMovil(newValue);
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<PerfilPreInversionBeneficiarioCubit,
                    PerfilPreInversionBeneficiarioState>(
                  builder: (context, state) {
                    final perfilPreInversionBeneficiario =
                        state.perfilPreInversionBeneficiario;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BlocBuilder<TipoDiscapacidadCubit,
                              TipoDiscapacidadState>(
                            builder: (context, state) {
                              if (state is TiposDiscapacidadesLoaded) {
                                return DropdownButtonFormField(
                                    value: perfilPreInversionBeneficiario
                                                ?.tipoDiscapacidadId !=
                                            ''
                                        ? perfilPreInversionBeneficiario!
                                            .tipoDiscapacidadId
                                        : null,
                                    items: state.tiposDiscapacidades!
                                        .map<DropdownMenuItem<String>>(
                                            (TipoDiscapacidadEntity value) {
                                      return DropdownMenuItem<String>(
                                        value: value.tipoDiscapacidadId,
                                        child: Text(value.nombre),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      perfilPreInversionBeneficiarioCubit
                                          .changeDiscapacidad(value);
                                    },
                                    hint: const Text('Discapacidad'));
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                              controller: calificacionSisbenCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Puntaje Sisben',
                                  labelText: 'Puntaje Sisben'),
                              onSaved: (String? newValue) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeCalificacionSisben(newValue);
                              }),
                        ),
                      ],
                    );
                  },
                )
              ]),
            ),
          );
        }));
  }

  void calcularEdad(String fechaNacimiento) {
    DateTime edadDt = DateTime.parse(fechaNacimiento);
    var currentYear = DateTime.now().year;
    var edad = currentYear - edadDt.year;
    edadCtrl.text = edad.toString();
  }
}
