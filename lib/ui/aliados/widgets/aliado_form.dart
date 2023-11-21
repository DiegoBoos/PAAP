import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/aliado/aliado_cubit.dart';
import '../../cubits/municipio/municipio_cubit.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class AliadoForm extends StatefulWidget {
  const AliadoForm({
    Key? key,
    required this.aliado,
  }) : super(key: key);

  final AliadoEntity? aliado;

  @override
  State<AliadoForm> createState() => _AliadoFormState();
}

class _AliadoFormState extends State<AliadoForm> {
  List<MunicipioEntity> allMunicipios = [];
  List<MunicipioEntity> municipiosFiltered = [];

  final aliadoIdCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final fechaCreacionCtrl = TextEditingController();
  final nombreContactoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final telefonoFijoCtrl = TextEditingController();
  final telefonoMovilCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  String? municipioId;
  final experienciaCtrl = TextEditingController();
  final fechaActivacionCtrl = TextEditingController();
  final fechaDesactivacionCtrl = TextEditingController();
  final fechaCambioCtrl = TextEditingController();
  String? activo;

  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();

    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    allMunicipios = municipioCubit.state.municipios!;
    municipiosFiltered = allMunicipios;

    setState(() {
      aliadoIdCtrl.text = widget.aliado?.aliadoId ?? '';
      nombreCtrl.text = widget.aliado?.nombre ?? '';
      fechaCreacionCtrl.text = widget.aliado?.fechaCreacion ?? '';
      nombreContactoCtrl.text = widget.aliado?.nombreContacto ?? '';
      direccionCtrl.text = widget.aliado?.direccion ?? '';
      telefonoFijoCtrl.text = widget.aliado?.telefonoFijo ?? '';
      telefonoMovilCtrl.text = widget.aliado?.telefonoMovil ?? '';
      correoCtrl.text = widget.aliado?.correo ?? '';
      municipioId = widget.aliado?.municipioId;
      experienciaCtrl.text = widget.aliado?.experiencia ?? '';

      if (widget.aliado != null && widget.aliado?.fechaActivacion != '') {
        fechaActivacionCtrl.text =
            dateFormat.format(DateTime.parse(widget.aliado!.fechaActivacion));
      }

      if (widget.aliado != null && widget.aliado?.fechaDesactivacion != '') {
        fechaDesactivacionCtrl.text = dateFormat
            .format(DateTime.parse(widget.aliado!.fechaDesactivacion));
      }

      fechaCambioCtrl.text = widget.aliado?.fechaCambio ?? '';
      activo = widget.aliado?.activo;
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<AliadoCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text(
            'Información del aliado',
            style: Styles.titleStyle,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: aliadoIdCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'ID Aliado', labelText: 'ID Aliado'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido*';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    aliadoCubit.changeAliadoId(newValue);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                    controller: experienciaCtrl,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Años de experiencia',
                        labelText: 'Años de experiencia'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido*';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      aliadoCubit.changeExperiencia(newValue);
                    }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
              controller: nombreCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Nombre', labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
                }
                return null;
              },
              onSaved: (String? newValue) {
                aliadoCubit.changeNombre(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
            controller: fechaCreacionCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            onSaved: (String? newValue) {
              aliadoCubit.changeFechaCreacion(newValue);
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Creacion',
                labelText: 'Fecha Creacion',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050));

                      if (newDate == null) return;

                      fechaCreacionCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            isExpanded: true,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Municipio', labelText: 'Municipio'),
            value: municipioId,
            items: municipiosFiltered
                .map<DropdownMenuItem<String>>((MunicipioEntity value) {
              return DropdownMenuItem<String>(
                value: value.id,
                child: Text(value.nombre),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Campo Requerido*';
              }
              return null;
            },
            onChanged: (String? value) {
              setState(() {
                municipioId = value;
              });
            },
            onSaved: (String? newValue) {
              aliadoCubit.changeMunicipio(newValue);
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              controller: nombreContactoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Nombre del contacto',
                  labelText: 'Nombre del contacto'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
                }
                return null;
              },
              onSaved: (String? newValue) {
                aliadoCubit.changeNombreContacto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: direccionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Dirección', labelText: 'Dirección'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
                }
                return null;
              },
              onSaved: (String? newValue) {
                aliadoCubit.changeDireccion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: correoCtrl,
              maxLines: null,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Correo', labelText: 'Correo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Email no válido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                aliadoCubit.changeCorreo(newValue);
              }),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                    controller: telefonoFijoCtrl,
                    keyboardType: TextInputType.number,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Teléfono Fijo', labelText: 'Teléfono Fijo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido*';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      aliadoCubit.changeTelefonoFijo(newValue);
                    }),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                    controller: telefonoMovilCtrl,
                    keyboardType: TextInputType.number,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Teléfono Móvil',
                        labelText: 'Teléfono Móvil'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido*';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      aliadoCubit.changeTelefonoMovil(newValue);
                    }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: fechaDesactivacionCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            onSaved: (String? newValue) {
              aliadoCubit.changeFechaDesactivacion(newValue);
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Desactivacion',
                labelText: 'Fecha Desactivacion',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050));

                      if (newDate == null) return;

                      fechaDesactivacionCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: fechaActivacionCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            onSaved: (String? newValue) {
              aliadoCubit.changeFechaActivacion(newValue);
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Activacion',
                labelText: 'Fecha Activacion',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050));

                      if (newDate == null) return;

                      fechaActivacionCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: fechaCambioCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            onSaved: (String? newValue) {
              aliadoCubit.changeFechaCambio(newValue);
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Cambio',
                labelText: 'Fecha Cambio',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050));

                      if (newDate == null) return;

                      fechaCambioCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AliadoCubit, AliadoState>(
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Está activo en la alianza'),
                value: state.aliado.activo == 'true' ? true : false,
                onChanged: (bool? value) {
                  aliadoCubit.changeActivo(value.toString());
                },
              );
            },
          )
        ]),
      ),
    );
  }
}
