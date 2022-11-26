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
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocListener<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(
      listener: (context, state) {
        if (state is PerfilPreInversionBeneficiarioLoaded) {
          final perfilPreInversionBeneficiarioLoaded =
              state.perfilPreInversionBeneficiarioLoaded;

          if (perfilPreInversionBeneficiarioLoaded
                  .conyugeFechaExpedicionDocumento !=
              '') {
            dateFormat.format(DateTime.parse(
                perfilPreInversionBeneficiarioLoaded
                    .conyugeFechaExpedicionDocumento));
          }

          if (perfilPreInversionBeneficiarioLoaded.conyugeFechaNacimiento !=
              '') {
            dateFormat.format(DateTime.parse(
                perfilPreInversionBeneficiarioLoaded.conyugeFechaNacimiento));
          }
        }
      },
      child: BlocBuilder<PerfilPreInversionBeneficiarioCubit,
          PerfilPreInversionBeneficiarioState>(builder: (context, state) {
        final perfilPreInversionBeneficiario =
            perfilPreInversionBeneficiarioCubit
                .state.perfilPreInversionBeneficiario;
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
                        value: perfilPreInversionBeneficiario
                                    .conyugeTipoIdentificacionId !=
                                ''
                            ? perfilPreInversionBeneficiario
                                .conyugeTipoIdentificacionId
                            : null,
                        items: state.tiposIdentificaciones
                            ?.map<DropdownMenuItem<String>>(
                                (TipoIdentificacionEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.tipoIdentificacionId,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Campo Requerido';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeTipoIdentificacion(value);
                        },
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Tipo de documento',
                            labelText: 'Tipo de documento'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.conyugeId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Documento de identificación',
                      labelText: 'Documento de identificación'),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  }),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeConyugeDocumento(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                key: UniqueKey(),
                initialValue: perfilPreInversionBeneficiario
                    .conyugeFechaExpedicionDocumento,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Requerido';
                  }
                  if (DateTime.tryParse(value) == null) {
                    return 'No es una fecha válida';
                  }
                  return null;
                },
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Fecha de expedición',
                    labelText: 'Fecha de expedición',
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: perfilPreInversionBeneficiario
                                          .conyugeFechaExpedicionDocumento !=
                                      ''
                                  ? DateTime.parse(
                                      perfilPreInversionBeneficiario
                                          .conyugeFechaExpedicionDocumento)
                                  : DateTime.now(),
                              firstDate: DateTime(1000),
                              lastDate: DateTime(3000));

                          if (newDate == null) return;

                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeFechaExpedicion(
                                  dateFormat.format(newDate));
                        },
                        icon: const Icon(Icons.calendar_today))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.conyugeNombre1,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Conyuge Nombre 1',
                            labelText: 'Conyuge Nombre 1'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        }),
                        onSaved: (String? newValue) {
                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeNombre1(newValue);
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.conyugeApellido1,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Conyuge Apellido 1',
                            labelText: 'Conyuge Apellido 1'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        }),
                        onSaved: (String? newValue) {
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
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.conyugeNombre2,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Conyuge Nombre 2',
                            labelText: 'Conyuge Nombre 2'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        }),
                        onSaved: (String? newValue) {
                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeNombre2(newValue);
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.conyugeApellido2,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Conyuge Apellido 2',
                            labelText: 'Conyuge Apellido 2'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        }),
                        onSaved: (String? newValue) {
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
                        value:
                            perfilPreInversionBeneficiario.conyugeGeneroId != ''
                                ? perfilPreInversionBeneficiario.conyugeGeneroId
                                : null,
                        items: state.generos?.map<DropdownMenuItem<String>>(
                            (GeneroEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.generoId,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Campo Requerido';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeGenero(value);
                        },
                        hint: const Text('Género'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: UniqueKey(),
                initialValue:
                    perfilPreInversionBeneficiario.conyugeFechaNacimiento,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Requerido';
                  }
                  if (DateTime.tryParse(value) == null) {
                    return 'No es una fecha válida';
                  }

                  return null;
                },
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Fecha de nacimiento',
                    labelText: 'Fecha de nacimiento',
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: perfilPreInversionBeneficiario
                                          .conyugeFechaNacimiento !=
                                      ''
                                  ? DateTime.parse(
                                      perfilPreInversionBeneficiario
                                          .conyugeFechaNacimiento)
                                  : DateTime.now(),
                              firstDate: DateTime(1000),
                              lastDate: DateTime(3000));

                          if (newDate == null) return;

                          perfilPreInversionBeneficiarioCubit
                              .changeConyugeFechaNacimiento(
                                  dateFormat.format(newDate));
                        },
                        icon: const Icon(Icons.calendar_today))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.ingresosMensuales,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Ingresos Mensuales',
                            labelText: 'Ingresos Mensuales'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        }),
                        onSaved: (String? newValue) {
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
                              value: perfilPreInversionBeneficiario
                                          .conyugeGrupoEspecialId !=
                                      ''
                                  ? perfilPreInversionBeneficiario
                                      .conyugeGrupoEspecialId
                                  : null,
                              items: state.gruposEspeciales
                                  ?.map<DropdownMenuItem<String>>(
                                      (GrupoEspecialEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.grupoEspecialId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Campo Requerido';
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeConyugeGrupoEspecial(value);
                              },
                              hint: const Text('Grupo Especial'));
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            ]),
          ),
        );
      }),
    );
  }
}
