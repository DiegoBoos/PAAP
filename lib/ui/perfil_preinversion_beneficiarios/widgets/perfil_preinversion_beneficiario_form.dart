import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/actividad_economica/actividad_economica_cubit.dart';
import '../../../domain/cubits/estado_civil/estado_civil_cubit.dart';
import '../../../domain/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/residencia/residencia_cubit.dart';
import '../../../domain/cubits/tipo_discapacidad/tipo_discapacidad_cubit.dart';
import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/entities/estado_civil_entity.dart';
import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/entities/residencia_entity.dart';
import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilPreInversionBeneficiarioForm extends StatefulWidget {
  const PerfilPreInversionBeneficiarioForm({super.key});

  @override
  State<PerfilPreInversionBeneficiarioForm> createState() =>
      _PerfilPreInversionBeneficiarioFormState();
}

class _PerfilPreInversionBeneficiarioFormState
    extends State<PerfilPreInversionBeneficiarioForm> {
  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocListener<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(listener: (context, state) {
      if (state is PerfilPreInversionBeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }
    }, child: BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(builder: (context, state) {
      final perfilPreInversionBeneficiario =
          state.perfilPreInversionBeneficiario;

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
                        value: perfilPreInversionBeneficiario.residenciaId != ''
                            ? perfilPreInversionBeneficiario.residenciaId
                            : null,
                        items: state.residencias?.map<DropdownMenuItem<String>>(
                            (ResidenciaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.residenciaId,
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
                              .changeResidencia(value);
                        },
                        hint: const Text('Residencia'));
                  }

                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<EstadoCivilCubit, EstadoCivilState>(
                builder: (context, state) {
                  if (state is EstadosCivilesLoaded) {
                    return DropdownButtonFormField(
                        value:
                            perfilPreInversionBeneficiario.estadoCivilId != ''
                                ? perfilPreInversionBeneficiario.estadoCivilId
                                : null,
                        items: state.estadosCiviles
                            ?.map<DropdownMenuItem<String>>(
                                (EstadoCivilEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.estadoCivilId,
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
                              .changeEstadoCivil(value);
                        },
                        hint: const Text('Estado Civil'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<NivelEscolarCubit, NivelEscolarState>(
                builder: (context, state) {
                  if (state is NivelesEscolaresLoaded) {
                    return DropdownButtonFormField(
                        value:
                            perfilPreInversionBeneficiario.nivelEscolarId != ''
                                ? perfilPreInversionBeneficiario.nivelEscolarId
                                : null,
                        items: state.nivelesEscolares
                            ?.map<DropdownMenuItem<String>>(
                                (NivelEscolarEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.nivelEscolarId,
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
                              .changeNivelEscolar(value);
                        },
                        hint: const Text('Nivel Escolar'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<ActividadEconomicaCubit, ActividadEconomicaState>(
                builder: (context, state) {
                  if (state is ActividadesEconomicasLoaded) {
                    return DropdownButtonFormField(
                        value: perfilPreInversionBeneficiario
                                    .actividadEconomicaId !=
                                ''
                            ? perfilPreInversionBeneficiario
                                .actividadEconomicaId
                            : null,
                        items: state.actividadesEconomicas
                            ?.map<DropdownMenuItem<String>>(
                                (ActividadEconomicaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.actividadEconomicaId,
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
                              .changeActividadEconomica(value);
                        },
                        hint: const Text('Actividad Económica'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<TipoDiscapacidadCubit, TipoDiscapacidadState>(
                builder: (context, state) {
                  if (state is TiposDiscapacidadesLoaded) {
                    return DropdownButtonFormField(
                        value: perfilPreInversionBeneficiario
                                    .tipoDiscapacidadId !=
                                ''
                            ? perfilPreInversionBeneficiario.tipoDiscapacidadId
                            : null,
                        items: state.tiposDiscapacidades
                            ?.map<DropdownMenuItem<String>>(
                                (TipoDiscapacidadEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.tipoDiscapacidadId,
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
                              .changeDiscapacidad(value);
                        },
                        hint: const Text('Discapacidad'));
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
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.ingresosDiarios,
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
                          perfilPreInversionBeneficiarioCubit
                              .changeIngresosDiarios(newValue);
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        key: UniqueKey(),
                        initialValue:
                            perfilPreInversionBeneficiario.diasTrabajo,
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
                          perfilPreInversionBeneficiarioCubit
                              .changeDiasTrabajados(newValue);
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue:
                      perfilPreInversionBeneficiario.calificacionSisben,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Puntaje Sisben', labelText: 'Puntaje Sisben'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeCalificacionSisben(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.latitud,
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
                    perfilPreInversionBeneficiarioCubit.changeLatitud(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.longitud,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeLongitud(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.cedulaCatastral,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeExperiencia(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.miembrosHogar,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeMiembrosHogar(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue:
                      perfilPreInversionBeneficiario.miembrosEcoActivos,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeMiembrosEcoActivos(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue:
                      perfilPreInversionBeneficiario.ingresosMensuales,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeIngresosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.gastosMensuales,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeGastosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue:
                      perfilPreInversionBeneficiario.activoInmobiliario,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoInmobiliario(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.activoFinanciero,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoFinanciero(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.activoProductivo,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoProductivo(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.activoCorriente,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoCorriente(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.activo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Total Activo', labelText: 'Total Activo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit.changeActivo(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.nombreFinca,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre Finca', labelText: 'Nombre Finca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeNombreFinca(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue:
                      perfilPreInversionBeneficiario.nombreOrganizacion,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeNombreOrganizacion(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.mesesAsociado,
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
                    perfilPreInversionBeneficiarioCubit
                        .changeMesesAsociado(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilPreInversionBeneficiario.nota,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nota', labelText: 'Nota'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit.changeNota(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Cotiza BEPS'),
                  value: perfilPreInversionBeneficiario.cotizanteBeps == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilPreInversionBeneficiarioCubit
                        .changeCotizanteBeps(value);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Acceso Explotación Tierra'),
                  value:
                      perfilPreInversionBeneficiario.accesoExplotacionTierra ==
                              'true'
                          ? true
                          : false,
                  onChanged: (bool? value) {
                    perfilPreInversionBeneficiarioCubit
                        .changeAccesoExplotacionTierra(value);
                  }),
            ],
          ),
        ),
      );
    }));
  }
}
