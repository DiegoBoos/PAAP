import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/entities/perfil_beneficiario_entity.dart';

import '../../../data/models/municipio_model.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../domain/cubits/vereda/vereda_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/entities/vereda_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilBeneficiarioForm extends StatefulWidget {
  const PerfilBeneficiarioForm({super.key});

  @override
  State<PerfilBeneficiarioForm> createState() => _PerfilBeneficiarioFormState();
}

class _PerfilBeneficiarioFormState extends State<PerfilBeneficiarioForm> {
  List<MunicipioEntity> municipiosFiltered = [];
  List<VeredaEntity> veredasFiltered = [];

  String? departamentoId;
  String? municipioId;
  String? veredaId;

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<PerfilBeneficiarioCubit>(context).initState();
    BlocProvider.of<MunicipioCubit>(context).initState();
  }

  @override
  void initState() {
    super.initState();
    loadMunicipiosVeredas();
  }

  Future<void> loadMunicipiosVeredas() async {
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    await municipioCubit.getMunicipiosDB();

    if (municipioCubit.state is MunicipiosLoaded) {
      municipiosFiltered = municipioCubit.state.municipios!;
    }

    if (perfilBeneficiarioCubit.state is PerfilBeneficiarioLoaded) {
      final perfilPreinversionBeneficiario =
          perfilBeneficiarioCubit.state.perfilBeneficiario;
      loadDepartamentoMunicipioVereda(perfilPreinversionBeneficiario);
    }
  }

  void loadDepartamentoMunicipioVereda(
      PerfilBeneficiarioEntity perfilBeneficiarioChanged) {
    final municipioIdPerfilBeneficiario = perfilBeneficiarioChanged.municipioId;

    final municipio = municipiosFiltered.firstWhere(
        (municipio) => municipio.id == municipioIdPerfilBeneficiario,
        orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

    if (municipio.id != '') {
      setState(() {
        departamentoId = municipio.departamentoid;
        municipioId = perfilBeneficiarioChanged.municipioId != ''
            ? perfilBeneficiarioChanged.municipioId
            : null;

        loadVeredasByMunicipio(municipioId, perfilBeneficiarioChanged);

        veredaId = perfilBeneficiarioChanged.veredaId != ''
            ? perfilBeneficiarioChanged.veredaId
            : null;
      });
    }
  }

  void loadVeredasByMunicipio(String? municipioId,
      PerfilBeneficiarioEntity perfilBeneficiarioChanged) async {
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);
    await veredaCubit.getVeredasByMunicipioDB(municipioId!);
    veredaId = perfilBeneficiarioChanged.veredaId != ''
        ? perfilBeneficiarioChanged.veredaId
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context, listen: true);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    return BlocListener<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
        listener: (context, state) {
      if (state is PerfilBeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }

      if (state is PerfilBeneficiarioChanged) {
        final perfilBeneficiarioChanged = state.perfilBeneficiarioChanged;

        final municipioIdPerfilBeneficiario =
            perfilBeneficiarioChanged.municipioId;

        final municipio = municipiosFiltered.firstWhere(
            (municipio) => municipio.id == municipioIdPerfilBeneficiario,
            orElse: () =>
                MunicipioModel(id: '', nombre: '', departamentoid: ''));

        if (municipio.id != '') {
          departamentoId = municipio.departamentoid;
          municipioId = perfilBeneficiarioChanged.municipioId != ''
              ? perfilBeneficiarioChanged.municipioId
              : null;

          loadVeredasByMunicipio(municipioId, perfilBeneficiarioChanged);
        }
      }
    }, child: BlocBuilder<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
            builder: (context, state) {
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
                        value: departamentoId,
                        items: state.departamentos
                            ?.map<DropdownMenuItem<String>>(
                                (DepartamentoEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
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
                          setState(() {
                            municipiosFiltered = municipioCubit
                                .state.municipios!
                                .where(((municipio) =>
                                    municipio.departamentoid == value))
                                .toList();

                            departamentoId = value;
                            municipioId = null;
                            veredaId = null;
                          });
                        },
                        hint: const Text('Departamento'));
                  }
                  return Container();
                },
              ),
              if (departamentoId != null)
                BlocBuilder<MunicipioCubit, MunicipioState>(
                  builder: (context, state) {
                    return DropdownButtonFormField(
                        isExpanded: true,
                        value: municipioId,
                        items: municipiosFiltered.map<DropdownMenuItem<String>>(
                            (MunicipioEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
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
                          veredaCubit.getVeredasByMunicipioDB(value!);

                          setState(() {
                            municipioId = value;
                            veredaId = null;
                          });
                        },
                        hint: const Text('Municipio'));
                  },
                ),
              if (municipioId != null)
                BlocBuilder<VeredaCubit, VeredaState>(
                  builder: (context, state) {
                    if (state is VeredasLoaded) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          value: veredaId,
                          items: state.veredasLoaded!
                              .map<DropdownMenuItem<String>>(
                                  (VeredaEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.veredaId,
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
                            setState(() {
                              veredaId = value;
                            });
                          },
                          hint: const Text('Vereda'));
                    }
                    return Container();
                  },
                ),
              BlocBuilder<TipoTenenciaCubit, TipoTenenciaState>(
                builder: (context, state) {
                  if (state is TiposTenenciasLoaded) {
                    return DropdownButtonFormField(
                        isExpanded: true,
                        value: perfilBeneficiario.tipoTenenciaId != ''
                            ? perfilBeneficiario.tipoTenenciaId
                            : null,
                        items: state.tiposTenencias
                            ?.map<DropdownMenuItem<String>>(
                                (TipoTenenciaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.tipoTenenciaId,
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
                          perfilBeneficiarioCubit.changeTipoTenencia(value);
                        },
                        hint: const Text('Tipo de tenencia'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilBeneficiario.areaFinca,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Finca', labelText: 'Área Finca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilBeneficiarioCubit.changeAreaFinca(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilBeneficiario.areaProyecto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Proyecto', labelText: 'Área Proyecto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilBeneficiarioCubit.changeAreaProyecto(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Es asociado'),
                  value: perfilBeneficiario.asociado == 'true' ? true : false,
                  onChanged: (bool? value) {
                    perfilBeneficiarioCubit.changeAsociado(value);
                  }),
              SwitchListTile(
                  title: const Text('Está activo en la alianza'),
                  value: perfilBeneficiario.activo == 'true' ? true : false,
                  onChanged: (bool? value) {
                    perfilBeneficiarioCubit.changeActivo(value);
                  }),
              SwitchListTile(
                  title: const Text('Fue beneficiado'),
                  value: perfilBeneficiario.fueBeneficiado == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilBeneficiarioCubit.changeFueBeneficiado(value);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilBeneficiario.cualBeneficio,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Cuál Beneficio', labelText: 'Cuál Beneficio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    perfilBeneficiarioCubit.changeCualBeneficio(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  key: UniqueKey(),
                  initialValue: perfilBeneficiario.experiencia,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Experiencia producto',
                      labelText: 'Experiencia producto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
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
