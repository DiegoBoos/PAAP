import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../ui/cubits/genero/genero_cubit.dart';
import '../../../ui/cubits/grupo_especial/grupo_especial_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../ui/cubits/tipo_identificacion/tipo_identificacion_cubit.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ConyugeForm extends StatefulWidget {
  const ConyugeForm({super.key, required this.perfilPreInversionBeneficiario});
  final PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario;

  @override
  State<ConyugeForm> createState() => _ConyugeFormState();
}

class _ConyugeFormState extends State<ConyugeForm> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  String? conyugeTipoIdentificacionId;
  String? conyugeGeneroId;
  String? conyugeGrupoEspecialId;

  final conyugeIdCtrl = TextEditingController();
  final conyugeFechaExpedicionDocumentoCtrl = TextEditingController();
  final conyugeNombre1Ctrl = TextEditingController();
  final conyugeApellido1Ctrl = TextEditingController();
  final conyugeNombre2Ctrl = TextEditingController();
  final conyugeApellido2Ctrl = TextEditingController();
  final conyugeFechaNacimientoCtrl = TextEditingController();
  final ingresosMensualesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadConyuge(widget.perfilPreInversionBeneficiario);
  }

  void loadConyuge(
      PerfilPreInversionBeneficiarioEntity perfilPreInversionBeneficiario) {
    setState(() {
      final conyugeFechaExpedicionDocumento =
          perfilPreInversionBeneficiario.conyugeFechaExpedicionDocumento;

      final conyugeFechaNacimiento =
          perfilPreInversionBeneficiario.conyugeFechaNacimiento;

      conyugeTipoIdentificacionId =
          perfilPreInversionBeneficiario.conyugeTipoIdentificacionId;

      conyugeGeneroId = perfilPreInversionBeneficiario.conyugeGeneroId;

      conyugeGrupoEspecialId =
          perfilPreInversionBeneficiario.conyugeGrupoEspecialId;

      conyugeIdCtrl.text = perfilPreInversionBeneficiario.conyugeId ?? '';

      if (conyugeFechaExpedicionDocumento != null &&
          conyugeFechaExpedicionDocumento != '') {
        conyugeFechaExpedicionDocumentoCtrl.text =
            dateFormat.format(DateTime.parse(conyugeFechaExpedicionDocumento));
      }

      conyugeNombre1Ctrl.text =
          perfilPreInversionBeneficiario.conyugeNombre1 ?? '';
      conyugeApellido1Ctrl.text =
          perfilPreInversionBeneficiario.conyugeApellido1 ?? '';
      conyugeNombre2Ctrl.text =
          perfilPreInversionBeneficiario.conyugeNombre2 ?? '';
      conyugeApellido2Ctrl.text =
          perfilPreInversionBeneficiario.conyugeApellido2 ?? '';
      conyugeGeneroId = perfilPreInversionBeneficiario.conyugeGeneroId;

      if (conyugeFechaNacimiento != null && conyugeFechaNacimiento != '') {
        conyugeFechaNacimientoCtrl.text =
            dateFormat.format(DateTime.parse(conyugeFechaNacimiento));
      }

      ingresosMensualesCtrl.text =
          perfilPreInversionBeneficiario.conyugeIngresosMensuales ?? '';

      conyugeGrupoEspecialId =
          perfilPreInversionBeneficiario.conyugeGrupoEspecialId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(builder: (context, state) {
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
                    isExpanded: true,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Tipo de identificación',
                        labelText: 'Tipo de identificación'),
                    value: conyugeTipoIdentificacionId,
                    items: state.tiposIdentificaciones!
                        .map<DropdownMenuItem<String>>(
                            (TipoIdentificacionEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.tipoIdentificacionId,
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
                      perfilPreInversionBeneficiarioCubit
                          .changeConyugeTipoIdentificacion(value);
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: conyugeIdCtrl,
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
              keyboardType: TextInputType.number,
              controller: conyugeFechaExpedicionDocumentoCtrl,
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
                            initialDate: conyugeFechaExpedicionDocumentoCtrl
                                        .text !=
                                    ''
                                ? DateTime.parse(
                                    conyugeFechaExpedicionDocumentoCtrl.text)
                                : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        conyugeFechaExpedicionDocumentoCtrl.text =
                            dateFormat.format(newDate);

                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeFechaExpedicion(
                                conyugeFechaExpedicionDocumentoCtrl.text);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      controller: conyugeNombre1Ctrl,
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
                      controller: conyugeApellido1Ctrl,
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
                      controller: conyugeNombre2Ctrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Conyuge Nombre 2',
                          labelText: 'Conyuge Nombre 2'),
                      onSaved: (String? newValue) {
                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeNombre2(newValue);
                      }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      controller: conyugeApellido2Ctrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Conyuge Apellido 2',
                          labelText: 'Conyuge Apellido 2'),
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
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Género', labelText: 'Género'),
                    value: conyugeGeneroId,
                    items: state.generos
                        ?.map<DropdownMenuItem<String>>((GeneroEntity value) {
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
                      perfilPreInversionBeneficiarioCubit
                          .changeConyugeGenero(value);
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: conyugeFechaNacimientoCtrl,
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
                            initialDate: conyugeFechaNacimientoCtrl.text != ''
                                ? DateTime.parse(
                                    conyugeFechaNacimientoCtrl.text)
                                : DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (newDate == null) return;

                        conyugeFechaNacimientoCtrl.text =
                            dateFormat.format(newDate);

                        perfilPreInversionBeneficiarioCubit
                            .changeConyugeFechaNacimiento(
                                conyugeFechaNacimientoCtrl.text);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: ingresosMensualesCtrl,
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
                      .changeConyugeIngresosMensuales(newValue);
                }),
            const SizedBox(height: 20),
            BlocBuilder<GrupoEspecialCubit, GrupoEspecialState>(
              builder: (context, state) {
                if (state is GruposEspecialesLoaded) {
                  return DropdownButtonFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Grupo Especial',
                        labelText: 'Grupo Especial'),
                    value: conyugeGrupoEspecialId,
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
                      perfilPreInversionBeneficiarioCubit
                          .changeConyugeGrupoEspecial(value);
                    },
                  );
                }
                return Container();
              },
            ),
          ]),
        ),
      );
    });
  }
}
