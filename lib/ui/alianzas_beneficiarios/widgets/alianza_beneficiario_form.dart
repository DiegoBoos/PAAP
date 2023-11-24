import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/actividad_economica/actividad_economica_cubit.dart';
import '../../../ui/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../../ui/cubits/estado_civil/estado_civil_cubit.dart';
import '../../../ui/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import '../../../ui/cubits/residencia/residencia_cubit.dart';
import '../../../ui/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/entities/estado_civil_entity.dart';
import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/entities/residencia_entity.dart';
import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class AlianzaBeneficiarioForm extends StatefulWidget {
  const AlianzaBeneficiarioForm({super.key});

  @override
  State<AlianzaBeneficiarioForm> createState() =>
      _AlianzaBeneficiarioFormState();
}

class _AlianzaBeneficiarioFormState extends State<AlianzaBeneficiarioForm> {
  String? residenciaId;
  String? estadoCivilId;
  String? nivelEscolarId;
  String? actividadEconomicaId;
  String? tipoDiscapacidadId;

  final ingresosDiariosCtrl = TextEditingController();
  final diasTrabajoCtrl = TextEditingController();
  final calificacionSisbenCtrl = TextEditingController();
  final latitudCtrl = TextEditingController();
  final longitudCtrl = TextEditingController();
  final cedulaCatastralCtrl = TextEditingController();
  final miembrosHogarCtrl = TextEditingController();
  final miembrosEcoActivosCtrl = TextEditingController();
  final ingresosMensualesCtrl = TextEditingController();
  final gastosMensualesCtrl = TextEditingController();
  final activoInmobiliarioCtrl = TextEditingController();
  final activoFinancieroCtrl = TextEditingController();
  final activoProductivoCtrl = TextEditingController();
  final activoCorrienteCtrl = TextEditingController();
  final totalActivoCtrl = TextEditingController();
  final nombreFincaCtrl = TextEditingController();
  final nombreOrganizacionCtrl = TextEditingController();
  final mesesAsociadoCtrl = TextEditingController();
  final notaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);

    final alianzaBeneficiario =
        alianzaBeneficiarioCubit.state.alianzaBeneficiario;

    setState(() {
      residenciaId = alianzaBeneficiario.residenciaId;
      estadoCivilId = alianzaBeneficiario.estadoCivilId;
      nivelEscolarId = alianzaBeneficiario.nivelEscolarId;
      actividadEconomicaId = alianzaBeneficiario.actividadEconomicaId;
      tipoDiscapacidadId = alianzaBeneficiario.tipoDiscapacidadId;
      ingresosDiariosCtrl.text = alianzaBeneficiario.ingresosDiarios ?? '';
      diasTrabajoCtrl.text = alianzaBeneficiario.diasTrabajo ?? '';
      calificacionSisbenCtrl.text =
          alianzaBeneficiario.calificacionSisben ?? '';
      latitudCtrl.text = alianzaBeneficiario.latitud ?? '';
      longitudCtrl.text = alianzaBeneficiario.longitud ?? '';
      cedulaCatastralCtrl.text = alianzaBeneficiario.cedulaCatastral ?? '';
      miembrosHogarCtrl.text = alianzaBeneficiario.miembrosHogar ?? '';
      miembrosEcoActivosCtrl.text =
          alianzaBeneficiario.miembrosEcoActivos ?? '';
      ingresosMensualesCtrl.text = alianzaBeneficiario.ingresosMensuales ?? '';
      gastosMensualesCtrl.text = alianzaBeneficiario.gastosMensuales ?? '';
      activoInmobiliarioCtrl.text =
          alianzaBeneficiario.activoInmobiliario ?? '';
      activoFinancieroCtrl.text = alianzaBeneficiario.activoFinanciero ?? '';
      activoProductivoCtrl.text = alianzaBeneficiario.activoProductivo ?? '';
      activoCorrienteCtrl.text = alianzaBeneficiario.activoCorriente ?? '';
      nombreFincaCtrl.text = alianzaBeneficiario.nombreFinca ?? '';
      nombreOrganizacionCtrl.text =
          alianzaBeneficiario.nombreOrganizacion ?? '';
      mesesAsociadoCtrl.text = alianzaBeneficiario.mesesAsociado ?? '';
      notaCtrl.text = alianzaBeneficiario.nota ?? '';
      calculateTotalActivo(alianzaBeneficiario);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<AlianzaBeneficiarioCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);

    return BlocBuilder<AlianzaBeneficiarioCubit, AlianzaBeneficiarioState>(
        builder: (context, state) {
      final alianzaBeneficiario = state.alianzaBeneficiario;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Información del Beneficiario con relación a la PreInversión',
                style: Styles.titleStyle,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ResidenciaCubit, ResidenciaState>(
                builder: (context, state) {
                  if (state is ResidenciasLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Residencia', labelText: 'Residencia'),
                      value: residenciaId,
                      items: state.residencias!.map<DropdownMenuItem<String>>(
                          (ResidenciaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.residenciaId,
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
                        alianzaBeneficiarioCubit.changeResidencia(value);
                      },
                    );
                  }

                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<EstadoCivilCubit, EstadoCivilState>(
                builder: (context, state) {
                  if (state is EstadosCivilesLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Estado Civil', labelText: 'Estado Civil'),
                      value: estadoCivilId,
                      items: state.estadosCiviles!
                          .map<DropdownMenuItem<String>>(
                              (EstadoCivilEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.estadoCivilId,
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
                        if (value == '1' || value == '3' || value == '4') {
                          alianzaBeneficiarioCubit.initConyuge();
                        }

                        alianzaBeneficiarioCubit.changeEstadoCivil(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<NivelEscolarCubit, NivelEscolarState>(
                builder: (context, state) {
                  if (state is NivelesEscolaresLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nivel Escolar',
                          labelText: 'Nivel Escolar'),
                      value: nivelEscolarId,
                      items: state.nivelesEscolares!
                          .map<DropdownMenuItem<String>>(
                              (NivelEscolarEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.nivelEscolarId,
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
                        alianzaBeneficiarioCubit.changeNivelEscolar(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<ActividadEconomicaCubit, ActividadEconomicaState>(
                builder: (context, state) {
                  if (state is ActividadesEconomicasLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Actividad Económica',
                          labelText: 'Actividad Económica'),
                      value: actividadEconomicaId,
                      items: state.actividadesEconomicas!
                          .map<DropdownMenuItem<String>>(
                              (ActividadEconomicaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.actividadEconomicaId,
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
                        alianzaBeneficiarioCubit
                            .changeActividadEconomica(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<TipoDiscapacidadCubit, TipoDiscapacidadState>(
                builder: (context, state) {
                  if (state is TiposDiscapacidadesLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Discapacidad', labelText: 'Discapacidad'),
                      value: tipoDiscapacidadId,
                      items: state.tiposDiscapacidades!
                          .map<DropdownMenuItem<String>>(
                              (TipoDiscapacidadEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoDiscapacidadId,
                          child: Text(value.nombre!),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        alianzaBeneficiarioCubit.changeDiscapacidad(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: ingresosDiariosCtrl,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Ingresos Diarios',
                            labelText: 'Ingresos Diarios'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        },
                        onSaved: (String? newValue) {
                          alianzaBeneficiarioCubit
                              .changeIngresosDiarios(newValue);
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: diasTrabajoCtrl,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Días Trabajados/mes',
                            labelText: 'Días Trabajados/mes'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Requerido';
                          }
                          return null;
                        },
                        onSaved: (String? newValue) {
                          alianzaBeneficiarioCubit
                              .changeDiasTrabajados(newValue);
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: calificacionSisbenCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Puntaje Sisben', labelText: 'Puntaje Sisben'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeCalificacionSisben(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: latitudCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ubicación - Latitud',
                      labelText: 'Ubicación - Latitud'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeLatitud(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: longitudCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ubicación Longitud',
                      labelText: 'Ubicación Longitud'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeLongitud(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cedulaCatastralCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Cédula Catastral',
                      labelText: 'Cédula Catastral'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeCedulaCatastral(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: miembrosHogarCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Miembros del hogar',
                      labelText: 'Miembros del hogar'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeMiembrosHogar(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: miembrosEcoActivosCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Miembros Economicamente Activos',
                      labelText: 'Miembros Economicamente Activos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeMiembrosEcoActivos(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ingresosMensualesCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ingresos Mensuales',
                      labelText: 'Ingresos Mensuales'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeIngresosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: gastosMensualesCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Gastos Mensuales',
                      labelText: 'Gastos Mensuales'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeGastosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: activoInmobiliarioCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Inmobiliario',
                      labelText: 'Activo Inmobiliario'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeActivoInmobiliario(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: activoFinancieroCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Financiero',
                      labelText: 'Activo Financiero'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeActivoFinanciero(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: activoProductivoCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Productivo',
                      labelText: 'Activo Productivo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeActivoProductivo(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: activoCorrienteCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Corriente',
                      labelText: 'Activo Corriente'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeActivoCorriente(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                enabled: false,
                controller: totalActivoCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Total Activo', labelText: 'Total Activo'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: nombreFincaCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre Finca', labelText: 'Nombre Finca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeNombreFinca(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: nombreOrganizacionCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Organizacion',
                      labelText: 'Nombre de la Organizacion'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeNombreOrganizacion(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: mesesAsociadoCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Meses en la Asociación',
                      labelText: 'Meses en la Asociación'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeMesesAsociado(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: notaCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nota', labelText: 'Nota'),
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeNota(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Cotiza BEPS'),
                  value: alianzaBeneficiario.cotizanteBeps == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    alianzaBeneficiarioCubit.changeCotizanteBeps(value);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Acceso Explotación Tierra'),
                  value: alianzaBeneficiario.accesoExplotacionTierra == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    alianzaBeneficiarioCubit
                        .changeAccesoExplotacionTierra(value);
                  }),
            ],
          ),
        ),
      );
    });
  }

  void calculateTotalActivo(AlianzaBeneficiarioEntity alianzaBeneficiario) {
    if (alianzaBeneficiario.activoCorriente != null &&
        alianzaBeneficiario.activoFinanciero != null &&
        alianzaBeneficiario.activoInmobiliario != null &&
        alianzaBeneficiario.activoProductivo != null) {
      final sum = double.parse(alianzaBeneficiario.activoCorriente!) +
          double.parse(alianzaBeneficiario.activoFinanciero!) +
          double.parse(alianzaBeneficiario.activoInmobiliario!) +
          double.parse(alianzaBeneficiario.activoProductivo!);
      totalActivoCtrl.text = sum.toString();
    }
  }
}
