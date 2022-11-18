import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../domain/cubits/vereda/vereda_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioPerfilForm extends StatefulWidget {
  const BeneficiarioPerfilForm({super.key});

  @override
  State<BeneficiarioPerfilForm> createState() => _BeneficiarioPerfilFormState();
}

class _BeneficiarioPerfilFormState extends State<BeneficiarioPerfilForm> {
  final cualBeneficioCtrl = TextEditingController();
  final experienciaCtrl = TextEditingController();
  final longitudCtrl = TextEditingController();
  final areaFincaCtrl = TextEditingController();
  final areaProyectoCtrl = TextEditingController();
  final latitudCtrl = TextEditingController();
  final cedulaCatastralCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PerfilBeneficiarioCubit>(context).initState();
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
            listener: (context, state) {
              if (state is PerfilBeneficiarioLoaded) {
                final perfilBeneficiarioLoaded =
                    state.perfilBeneficiarioLoaded!;
                areaFincaCtrl.text = perfilBeneficiarioLoaded.areaFinca;
                areaProyectoCtrl.text = perfilBeneficiarioLoaded.areaProyecto;
                cualBeneficioCtrl.text = perfilBeneficiarioLoaded.cualBeneficio;
                experienciaCtrl.text = perfilBeneficiarioLoaded.experiencia;
              }
            },
          ),
          BlocListener<PerfilPreInversionBeneficiarioCubit,
              PerfilPreInversionBeneficiarioState>(
            listener: (context, state) {
              if (state is PerfilPreInversionBeneficiarioLoaded) {
                final perfilPreInversionBeneficiarioLoaded =
                    state.perfilPreInversionBeneficiarioLoaded!;

                longitudCtrl.text =
                    perfilPreInversionBeneficiarioLoaded.latitud;
                longitudCtrl.text =
                    perfilPreInversionBeneficiarioLoaded.longitud;
                cedulaCatastralCtrl.text =
                    perfilPreInversionBeneficiarioLoaded.cedulaCatastral;
              }
            },
          ),
        ],
        child: BlocBuilder<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
            builder: (context, state) {
          final perfilBeneficiario = state.perfilBeneficiario;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Información del beneficiario con relación al perfil',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<DepartamentoCubit, DepartamentoState>(
                    builder: (context, state) {
                      if (state is DepartamentosLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: state.departamentos!
                                .map<DropdownMenuItem<String>>(
                                    (DepartamentoEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              municipioCubit
                                  .getMunicipiosByDepartamentoDB(value!);
                            },
                            hint: const Text('Departamento'));
                      }
                      return const SizedBox();
                    },
                  ),
                  BlocBuilder<MunicipioCubit, MunicipioState>(
                    builder: (context, state) {
                      if (state is MunicipiosLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            value: perfilBeneficiario?.municipioId != ''
                                ? perfilBeneficiario?.municipioId
                                : null,
                            items: state.municipios!
                                .map<DropdownMenuItem<String>>(
                                    (MunicipioEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              //veredaCubit.getVeredasByMunicipioDB(value!);
                            },
                            hint: const Text('Municipio'));
                      }
                      return const SizedBox();
                    },
                  ),
                  //TODO: Cargar veredas
                  /*  BlocBuilder<VeredaCubit, VeredaState>(
                    builder: (context, state) {
                      if (state is MunicipiosLoaded) {
                        return DropdownButtonFormField(
                      isExpanded: true,

                            items: state.veredas!
                                .map<DropdownMenuItem<String>>(
                                    (VeredaEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.veredaId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: const Text('Vereda'));
                      }
                      return const SizedBox();
                    },
                  ) */
                  BlocBuilder<TipoTenenciaCubit, TipoTenenciaState>(
                    builder: (context, state) {
                      if (state is TiposTenenciasLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            value: perfilBeneficiario?.tipoTenenciaId != ''
                                ? perfilBeneficiario?.tipoTenenciaId
                                : null,
                            items: state.tiposTenencias!
                                .map<DropdownMenuItem<String>>(
                                    (TipoTenenciaEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.tipoTenenciaId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              perfilBeneficiarioCubit.changeTipoTenencia(value);
                            },
                            hint: const Text('Tipo de tenencia'));
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: areaFincaCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área Finca', labelText: 'Área Finca'),
                      onSaved: (String? newValue) {
                        perfilBeneficiarioCubit.changeAreaFinca(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: areaProyectoCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Área Proyecto',
                          labelText: 'Área Proyecto'),
                      onSaved: (String? newValue) {
                        perfilBeneficiarioCubit.changeAreaProyecto(newValue);
                      }),
                  const SizedBox(height: 20),

                  BlocBuilder<PerfilPreInversionBeneficiarioCubit,
                      PerfilPreInversionBeneficiarioState>(
                    builder: (context, state) {
                      final perfilPreInversionBeneficiario =
                          state.perfilPreInversionBeneficiario;

                      return Column(
                        children: [
                          TextFormField(
                              controller: latitudCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Ubicación - Latitud',
                                  labelText: 'Ubicación - Latitud'),
                              onSaved: (String? newValue) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeLatitud(newValue);
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                              controller: longitudCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Ubicación Longitud',
                                  labelText: 'Ubicación Longitud'),
                              onSaved: (String? newValue) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeLongitud(newValue);
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                              controller: cedulaCatastralCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Cédula Catastral',
                                  labelText: 'Cédula Catastral'),
                              onSaved: (String? newValue) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeExperiencia(newValue);
                              }),
                          const SizedBox(height: 20),
                          SwitchListTile(
                              title: const Text('Cotiza BEPS'),
                              value: perfilPreInversionBeneficiario
                                          ?.cotizanteBeps ==
                                      'true'
                                  ? true
                                  : false,
                              onChanged: (bool? value) {
                                perfilPreInversionBeneficiarioCubit
                                    .changeCotizanteBeps(value);
                              }),
                        ],
                      );
                    },
                  ),

                  SwitchListTile(
                      title: const Text('Es asociado'),
                      value:
                          perfilBeneficiario?.asociado == 'true' ? true : false,
                      onChanged: (bool? value) {
                        perfilBeneficiarioCubit.changeAsociado(value);
                      }),

                  SwitchListTile(
                      title: const Text('Está activo en la alianza'),
                      value:
                          perfilBeneficiario?.activo == 'true' ? true : false,
                      onChanged: (bool? value) {
                        perfilBeneficiarioCubit.changeActivo(value);
                      }),
                  SwitchListTile(
                      title: const Text('Fue beneficiado'),
                      value: perfilBeneficiario?.fueBeneficiado == 'true'
                          ? true
                          : false,
                      onChanged: (bool? value) {
                        perfilBeneficiarioCubit.changeFueBeneficiado(value);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: cualBeneficioCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cuál Beneficio',
                          labelText: 'Cuál Beneficio'),
                      onSaved: (String? newValue) {
                        perfilBeneficiarioCubit.changeCualBeneficio(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: experienciaCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Experiencia producto',
                          labelText: 'Experiencia producto'),
                      onSaved: (String? newValue) {
                        perfilBeneficiarioCubit.changeExperiencia(newValue);
                      }),
                ],
              ),
            ),
          );
        }));
  }
}
