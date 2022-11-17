import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/actividad_economica/actividad_economica_cubit.dart';
import '../../../domain/cubits/nivel_escolar/nivel_escolar_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/residencia/residencia_cubit.dart';
import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/entities/residencia_entity.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    return BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(builder: (context, state) {
      final perfilPreinversionBeneficiario =
          state.perfilPreInversionBeneficiario;

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Información del Beneficiario con Relación a la PreInversión',
                style: Styles.titleStyle,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ResidenciaCubit, ResidenciaState>(
                builder: (context, state) {
                  if (state is ResidenciasLoaded) {
                    return DropdownButtonFormField(
                        items: state.residencias!.map<DropdownMenuItem<String>>(
                            (ResidenciaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.residenciaId,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          perfilPreInversionBeneficiarioCubit
                              .changeResidencia(value);
                        },
                        hint: const Text('Residencia'));
                  }

                  return const SizedBox();
                },
              ),
              BlocBuilder<NivelEscolarCubit, NivelEscolarState>(
                builder: (context, state) {
                  if (state is NivelesEscolaresLoaded) {
                    return DropdownButtonFormField(
                        items: state.nivelesEscolares!
                            .map<DropdownMenuItem<String>>(
                                (NivelEscolarEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.nivelEscolarId,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          perfilPreInversionBeneficiarioCubit
                              .changeNivelEscolar(value);
                        },
                        hint: const Text('Nivel Escolar'));
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<ActividadEconomicaCubit, ActividadEconomicaState>(
                builder: (context, state) {
                  if (state is ActividadesEconomicasLoaded) {
                    return DropdownButtonFormField(
                        items: state.actividadesEconomicas!
                            .map<DropdownMenuItem<String>>(
                                (ActividadEconomicaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.actividadEconomicaId,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          perfilPreInversionBeneficiarioCubit
                              .changeActividadEconomica(value);
                        },
                        hint: const Text('Actividad Económica'));
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            perfilPreinversionBeneficiario?.ingresosDiarios,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Ingresos Diarios',
                            labelText: 'Ingresos Diarios'),
                        onSaved: (String? newValue) {
                          perfilPreInversionBeneficiarioCubit
                              .changeIngresosDiarios(newValue);
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            perfilPreinversionBeneficiario?.diasTrabajo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Días Trabajados/mes',
                            labelText: 'Días Trabajados/mes'),
                        onSaved: (String? newValue) {
                          perfilPreInversionBeneficiarioCubit
                              .changeDiasTrabajados(newValue);
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.miembrosHogar,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Miembros del hogar',
                      labelText: 'Miembros del hogar'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeMiembrosHogar(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.miembrosEcoActivos,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Miembros Economicamente Activos',
                      labelText: 'Miembros Economicamente Activos'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeMiembrosEcoActivos(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.ingresosMensuales,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ingresos Mensuales',
                      labelText: 'Ingresos Mensuales'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeIngresosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.gastosMensuales,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Gastos Mensuales',
                      labelText: 'Gastos Mensuales'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeGastosMensuales(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.activoInmobiliario,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Inmobiliario',
                      labelText: 'Activo Inmobiliario'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoInmobiliario(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.activoFinanciero,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Financiero',
                      labelText: 'Activo Financiero'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoFinanciero(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.activoProductivo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Productivo',
                      labelText: 'Activo Productivo'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoProductivo(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.activoCorriente,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Activo Corriente',
                      labelText: 'Activo Corriente'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeActivoCorriente(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.activo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Total Activo', labelText: 'Total Activo'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit.changeActivo(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.nombreFinca,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre Finca', labelText: 'Nombre Finca'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeNombreFinca(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      perfilPreinversionBeneficiario?.nombreOrganizacion,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Organizacion',
                      labelText: 'Nombre de la Organizacion'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeNombreOrganizacion(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.mesesAsociado,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Meses en la Asociación',
                      labelText: 'Meses en la Asociación'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit
                        .changeMesesAsociado(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreinversionBeneficiario?.nota,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nota', labelText: 'Nota'),
                  onSaved: (String? newValue) {
                    perfilPreInversionBeneficiarioCubit.changeNota(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Acceso Explotación Tierra'),
                  value: false,
                  onChanged: (value) {
                    perfilPreinversionBeneficiario
                        ?.changeAccesoExplotacionTierra(value);
                  }),
            ],
          ),
        ),
      );
    });
  }
}
