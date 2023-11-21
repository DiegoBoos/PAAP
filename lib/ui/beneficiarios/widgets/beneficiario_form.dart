import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/beneficiario/beneficiario_cubit.dart';
import '../../cubits/genero/genero_cubit.dart';
import '../../cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../../domain/entities/beneficiario_entity.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioForm extends StatefulWidget {
  const BeneficiarioForm({Key? key, required this.beneficiario})
      : super(key: key);
  final BeneficiarioEntity? beneficiario;

  @override
  State<BeneficiarioForm> createState() => _BeneficiarioFormState();
}

class _BeneficiarioFormState extends State<BeneficiarioForm> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  final PageController pageViewController = PageController(initialPage: 1);

  final beneficiarioIdCtrl = TextEditingController();
  String? tipoIdentificacionId;
  final fechaExpedicionDocumentoCtrl = TextEditingController();
  final fechaNacimientoCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final nombre1Ctrl = TextEditingController();
  final nombre2Ctrl = TextEditingController();
  final apellido1Ctrl = TextEditingController();
  final apellido2Ctrl = TextEditingController();
  String? generoId;
  String? grupoEspecialId;
  final telefonoMovilCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    beneficiarioIdCtrl.text = widget.beneficiario?.beneficiarioId ?? '';
    tipoIdentificacionId = widget.beneficiario?.tipoIdentificacionId;
    if (widget.beneficiario != null &&
        widget.beneficiario!.fechaExpedicionDocumento != '') {
      fechaExpedicionDocumentoCtrl.text = dateFormat.format(
          DateTime.parse(widget.beneficiario!.fechaExpedicionDocumento));
    }

    if (widget.beneficiario != null &&
        widget.beneficiario!.fechaNacimiento != '') {
      fechaNacimientoCtrl.text = dateFormat
          .format(DateTime.parse(widget.beneficiario!.fechaNacimiento));
    }

    edadCtrl.text = widget.beneficiario?.edad.toString() ?? '';
    nombre1Ctrl.text = widget.beneficiario?.nombre1 ?? '';
    nombre2Ctrl.text = widget.beneficiario?.nombre2 ?? '';
    apellido1Ctrl.text = widget.beneficiario?.apellido1 ?? '';
    apellido2Ctrl.text = widget.beneficiario?.apellido2 ?? '';
    generoId = widget.beneficiario?.generoId;
    grupoEspecialId = widget.beneficiario?.grupoEspecialId;
    telefonoMovilCtrl.text = widget.beneficiario?.telefonoMovil ?? '';
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<BeneficiarioCubit>(context).initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
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

    return BlocBuilder<BeneficiarioCubit, BeneficiarioState>(
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
                final perfilId = vPerfilCubit.state.vPerfil!.perfilId;

                beneficiarioCubit.loadBeneficiario(perfilId);
              },
              onSaved: ((String? newValue) {
                beneficiarioCubit.changeBeneficiarioId(newValue);
              }),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TipoIdentificacionCubit, TipoIdentificacionState>(
              builder: (context, state) {
                if (state is TiposIdentificacionesLoaded) {
                  return DropdownButtonFormField(
                    isExpanded: true,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Tipo documento',
                        labelText: 'Tipo documento'),
                    value: tipoIdentificacionId,
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
                        hintText: 'Pertenece a un grupo especial',
                        labelText: 'Pertenece a un grupo especial'),
                    value: grupoEspecialId,
                    items: state.gruposEspeciales!
                        .map<DropdownMenuItem<String>>(
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
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
          ]),
        ),
      );
    });
  }
}
