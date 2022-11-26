import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/genero/genero_cubit.dart';
import '../../../domain/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioForm extends StatefulWidget {
  const BeneficiarioForm({super.key});

  @override
  State<BeneficiarioForm> createState() => _BeneficiarioFormState();
}

class _BeneficiarioFormState extends State<BeneficiarioForm> {
  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<BeneficiarioCubit>(context).initState();
  }

  final edadCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final vPerfilPreinversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
        listener: (context, state) {
      if (state is BeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }
      if (state is BeneficiarioLoaded) {
        final beneficiarioLoaded = state.beneficiarioLoaded;

        if (beneficiarioLoaded.fechaExpedicionDocumento != '') {
          dateFormat.format(
              DateTime.parse(beneficiarioLoaded.fechaExpedicionDocumento));
        }

        if (beneficiarioLoaded.fechaNacimiento != '') {
          dateFormat.format(DateTime.parse(beneficiarioLoaded.fechaNacimiento));

          calcularEdad(beneficiarioLoaded.fechaNacimiento);
        }
      }
    }, child: BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
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
              key: UniqueKey(),
              initialValue: beneficiario.beneficiarioId,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Documento de identificación',
                  labelText: 'Documento de identificación'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onFieldSubmitted: (String value) {
                final perfilPreInversionId = vPerfilPreinversionCubit
                    .state.vPerfilPreInversion!.perfilId;

                beneficiarioCubit.loadBeneficiario(value);

                perfilBeneficiarioCubit.loadPerfilBeneficiario(
                    perfilPreInversionId, value);

                perfilPreInversionBeneficiarioCubit
                    .loadPerfilPreInversionBeneficiario(
                        perfilPreInversionId, value);
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<TipoIdentificacionCubit, TipoIdentificacionState>(
              builder: (context, state) {
                if (state is TiposIdentificacionesLoaded) {
                  return DropdownButtonFormField(
                      value: beneficiario.tipoIdentificacionId != ''
                          ? beneficiario.tipoIdentificacionId
                          : null,
                      items: state.tiposIdentificaciones
                          ?.map<DropdownMenuItem<String>>(
                              (TipoIdentificacionEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoIdentificacionId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        beneficiarioCubit.changeTipoDocumento(value!);
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Campo Requerido';
                        }
                        return null;
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
              initialValue: beneficiario.fechaExpedicionDocumento,
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
                            initialDate:
                                beneficiario.fechaExpedicionDocumento != ''
                                    ? DateTime.parse(
                                        beneficiario.fechaExpedicionDocumento)
                                    : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        beneficiarioCubit
                            .changeFechaExpedicion(dateFormat.format(newDate));
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: UniqueKey(),
              initialValue: beneficiario.fechaNacimiento,
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
                            initialDate: beneficiario.fechaNacimiento != ''
                                ? DateTime.parse(beneficiario.fechaNacimiento)
                                : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        beneficiarioCubit
                            .changeFechaNacimiento(dateFormat.format(newDate));

                        calcularEdad(dateFormat.format(newDate));
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
                      controller: edadCtrl,
                      enabled: false,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Edad', labelText: 'Edad')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    key: UniqueKey(),
                    initialValue: beneficiario.telefonoMovil,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Teléfono', labelText: 'Teléfono'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                    onSaved: ((newValue) {
                      beneficiarioCubit.changeTelefonoMovil(newValue);
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      key: UniqueKey(),
                      initialValue: beneficiario.nombre1,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Primer Nombre',
                          labelText: 'Primer Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
                      onSaved: (String? newValue) {
                        beneficiarioCubit.changePrimerNombre(newValue);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      key: UniqueKey(),
                      initialValue: beneficiario.nombre2,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Segundo Nombre',
                          labelText: 'Segundo Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
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
                      key: UniqueKey(),
                      initialValue: beneficiario.apellido1,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Primer Apellido',
                          labelText: 'Primer Apellido'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
                      onSaved: (String? newValue) {
                        beneficiarioCubit.changePrimerApellido(newValue);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      key: UniqueKey(),
                      initialValue: beneficiario.apellido2,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Segundo Apellido',
                          labelText: 'Segundo Apellido'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
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
                            value: beneficiario.generoId != ''
                                ? beneficiario.generoId
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
                              beneficiarioCubit.changeGenero(value);
                            },
                            hint: const Text('Género'));
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
              builder: (context, state) {
                if (state is GruposEspecialesLoaded) {
                  return DropdownButtonFormField(
                      value: beneficiario.grupoEspecialId != ''
                          ? beneficiario.grupoEspecialId
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
                        beneficiarioCubit.changeGrupoEspecial(value!);
                      },
                      hint: const Text('Grupo Especial'));
                }
                return Container();
              },
            ),
            const SizedBox(width: 20),
            const SizedBox(height: 20),
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
