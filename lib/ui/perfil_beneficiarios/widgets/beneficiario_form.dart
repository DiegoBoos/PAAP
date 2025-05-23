import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../ui/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../ui/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../ui/cubits/genero/genero_cubit.dart';
import '../../../ui/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../../ui/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/entities/beneficiario_entity.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioForm extends StatefulWidget {
  const BeneficiarioForm({super.key, this.perfilBeneficiario});

  final PerfilBeneficiarioEntity? perfilBeneficiario;

  @override
  State<BeneficiarioForm> createState() => _BeneficiarioFormState();
}

class _BeneficiarioFormState extends State<BeneficiarioForm> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  String? tipoIdentificacionId;
  String? generoId;
  String? grupoEspecialId;

  final beneficiarioIdCtrl = TextEditingController();
  final fechaExpedicionDocumentoCtrl = TextEditingController();
  final fechaNacimientoCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final telefonoMovilCtrl = TextEditingController();
  final nombre1Ctrl = TextEditingController();
  final nombre2Ctrl = TextEditingController();
  final apellido1Ctrl = TextEditingController();
  final apellido2Ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);

    final beneficiario = BeneficiarioEntity(
        beneficiarioId: widget.perfilBeneficiario?.beneficiarioId,
        tipoIdentificacionId: widget.perfilBeneficiario?.tipoIdentificacionId,
        fechaExpedicionDocumento:
            widget.perfilBeneficiario?.fechaExpedicionDocumento,
        fechaNacimiento: widget.perfilBeneficiario?.fechaNacimiento,
        telefonoMovil: widget.perfilBeneficiario?.telefonoMovil,
        nombre1: widget.perfilBeneficiario?.nombre1,
        nombre2: widget.perfilBeneficiario?.nombre2,
        apellido1: widget.perfilBeneficiario?.apellido1,
        apellido2: widget.perfilBeneficiario?.apellido2,
        generoId: widget.perfilBeneficiario?.generoId,
        grupoEspecialId: widget.perfilBeneficiario?.grupoEspecialId);

    beneficiarioCubit.setBeneficiario(beneficiario);
    loadBeneficiario(beneficiario);
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<BeneficiarioCubit>(context).initState();
  }

  void loadBeneficiario(BeneficiarioEntity beneficiario) {
    tipoIdentificacionId = beneficiario.tipoIdentificacionId;
    generoId = beneficiario.generoId;
    grupoEspecialId = beneficiario.grupoEspecialId;

    beneficiarioIdCtrl.text = beneficiario.beneficiarioId ?? '';

    if (beneficiario.fechaExpedicionDocumento != null &&
        beneficiario.fechaExpedicionDocumento != '') {
      fechaExpedicionDocumentoCtrl.text = dateFormat
          .format(DateTime.parse(beneficiario.fechaExpedicionDocumento!));
    }

    if (beneficiario.fechaNacimiento != null &&
        beneficiario.fechaNacimiento != '') {
      fechaNacimientoCtrl.text =
          dateFormat.format(DateTime.parse(beneficiario.fechaNacimiento!));
      calcularEdad(beneficiario.fechaNacimiento!);
    }

    telefonoMovilCtrl.text = beneficiario.telefonoMovil ?? '';
    nombre1Ctrl.text = beneficiario.nombre1 ?? '';
    nombre2Ctrl.text = beneficiario.nombre2 ?? '';
    apellido1Ctrl.text = beneficiario.apellido1 ?? '';
    apellido2Ctrl.text = beneficiario.apellido2 ?? '';
  }

  void calcularEdad(String fechaNacimiento) {
    final fechaNac = DateTime.parse(fechaNacimiento);
    final now = DateTime.now();

    var edad = now.difference(fechaNac).inDays ~/ 365;

    edadCtrl.text = edad.toString();
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);

    final perfilId = vPerfilCubit.state.vPerfil!.perfilId!;

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
        listener: (context, state) {
      if (state is BeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }
      if (state is BeneficiarioLoaded) {
        final beneficiarioLoaded = state.beneficiarioLoaded;

        loadBeneficiario(beneficiarioLoaded);
      }
    }, child: BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
            builder: (context, state) {
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
              keyboardType: TextInputType.number,
              controller: beneficiarioIdCtrl,
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
                beneficiarioCubit.loadBeneficiario(value);
                perfilBeneficiarioCubit.loadPerfilBeneficiario(perfilId, value);
              },
              onSaved: ((String? newValue) {
                beneficiarioCubit.changeBeneficiarioId(newValue);
                perfilBeneficiarioCubit.changeBeneficiarioId(newValue);
              }),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TipoIdentificacionCubit, TipoIdentificacionState>(
              builder: (context, state) {
                if (state is TiposIdentificacionesLoaded) {
                  return DropdownButtonFormField(
                    isExpanded: true,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Tipo de identificación',
                        labelText: 'Tipo de identificación'),
                    value: tipoIdentificacionId,
                    items: state.tiposIdentificaciones!
                        .map<DropdownMenuItem<String>>(
                            (TipoIdentificacionEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.tipoIdentificacionId,
                        child: Text(value.nombre!),
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
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: fechaExpedicionDocumentoCtrl,
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
                            initialDate: fechaExpedicionDocumentoCtrl.text != ''
                                ? DateTime.parse(
                                    fechaExpedicionDocumentoCtrl.text)
                                : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        fechaExpedicionDocumentoCtrl.text =
                            dateFormat.format(newDate);

                        beneficiarioCubit.changeFechaExpedicion(
                            fechaExpedicionDocumentoCtrl.text);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: fechaNacimientoCtrl,
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
                            initialDate: fechaNacimientoCtrl.text != ''
                                ? DateTime.parse(fechaNacimientoCtrl.text)
                                : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        fechaNacimientoCtrl.text = dateFormat.format(newDate);

                        beneficiarioCubit
                            .changeFechaNacimiento(fechaNacimientoCtrl.text);

                        calcularEdad(fechaNacimientoCtrl.text);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      controller: edadCtrl,
                      enabled: false,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Edad', labelText: 'Edad')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: telefonoMovilCtrl,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Teléfono', labelText: 'Teléfono'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                    onSaved: ((String? newValue) {
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
                      controller: nombre1Ctrl,
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
                      controller: nombre2Ctrl,
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
                      controller: apellido1Ctrl,
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
                      controller: apellido2Ctrl,
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
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Género', labelText: 'Género'),
                          value: generoId,
                          items: state.generos!.map<DropdownMenuItem<String>>(
                              (GeneroEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.generoId,
                              child: Text(value.nombre!),
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
                        );
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
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Grupo Especial',
                        labelText: 'Grupo Especial'),
                    value: grupoEspecialId,
                    items: state.gruposEspeciales!
                        .map<DropdownMenuItem<String>>(
                            (GrupoEspecialEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.grupoEspecialId,
                        child: Text(value.nombre!),
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
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
          ]),
        ),
      );
    }));
  }
}
