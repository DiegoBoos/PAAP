import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/municipio_model.dart';
import '../../../domain/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../domain/cubits/vereda/vereda_cubit.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/entities/vereda_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class AlianzaBeneficiarioForm extends StatefulWidget {
  const AlianzaBeneficiarioForm({super.key});

  @override
  State<AlianzaBeneficiarioForm> createState() =>
      _AlianzaBeneficiarioFormState();
}

class _AlianzaBeneficiarioFormState extends State<AlianzaBeneficiarioForm> {
  List<MunicipioEntity> municipiosFiltered = [];
  List<VeredaEntity> veredasFiltered = [];

  String? departamentoId;
  String? municipioId;
  String? veredaId;
  String tipoTenenciaId = '';

  final areaFincaCtrl = TextEditingController();
  final areaProyectoCtrl = TextEditingController();
  final cualBeneficioCtrl = TextEditingController();
  final experienciaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAccesories();
  }

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<AlianzaBeneficiarioCubit>(context).initState();
  }

  Future<void> loadAccesories() async {
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    await municipioCubit.getMunicipiosDB();

    if (municipioCubit.state is MunicipiosLoaded) {
      municipiosFiltered = municipioCubit.state.municipios!;
    }

    if (alianzaBeneficiarioCubit.state is AlianzaBeneficiarioLoaded) {
      final alianzaBeneficiarioLoaded =
          alianzaBeneficiarioCubit.state.alianzaBeneficiario;

      loadAlianzaBeneficiario(alianzaBeneficiarioLoaded);
    }
  }

  void loadAlianzaBeneficiario(
      AlianzaBeneficiarioEntity alianzaBeneficiarioLoaded) {
    final alianzaBeneficiarioMunicipioId =
        alianzaBeneficiarioLoaded.municipioId;

    final alianzaBeneficiarioVeredaId = alianzaBeneficiarioLoaded.veredaId;

    final municipio = municipiosFiltered.firstWhere(
        (municipio) => municipio.id == alianzaBeneficiarioMunicipioId,
        orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

    if (municipio.id != '') {
      departamentoId = municipio.departamentoid;
      municipioId = alianzaBeneficiarioMunicipioId;

      loadVeredasByMunicipio(municipioId!, alianzaBeneficiarioVeredaId);
      experienciaCtrl.text = alianzaBeneficiarioLoaded.experiencia;
      cualBeneficioCtrl.text = alianzaBeneficiarioLoaded.cualBeneficio;
      areaProyectoCtrl.text = alianzaBeneficiarioLoaded.areaProyecto;
      areaFincaCtrl.text = alianzaBeneficiarioLoaded.areaFinca;
    }

    tipoTenenciaId = alianzaBeneficiarioLoaded.tipoTenenciaId;

    setState(() {});
  }

  void loadVeredasByMunicipio(
      String municipioId, String alianzaBeneficiarioVeredaId) async {
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    await veredaCubit.getVeredasByMunicipioDB(municipioId);
    veredaId =
        alianzaBeneficiarioVeredaId != '' ? alianzaBeneficiarioVeredaId : null;
  }

  @override
  Widget build(BuildContext context) {
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context, listen: true);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    final alianzaBeneficiario =
        alianzaBeneficiarioCubit.state.alianzaBeneficiario;

    return BlocListener<AlianzaBeneficiarioCubit, AlianzaBeneficiarioState>(
        listener: (context, state) {
      if (state is AlianzaBeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }

      if (state is AlianzaBeneficiarioLoaded) {
        final alianzaBeneficiarioLoaded = state.alianzaBeneficiarioLoaded;
        loadAlianzaBeneficiario(alianzaBeneficiarioLoaded);
      }
    }, child: BlocBuilder<AlianzaBeneficiarioCubit, AlianzaBeneficiarioState>(
            builder: (context, state) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Información del beneficiario con relación al alianza',
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

                          alianzaBeneficiarioCubit
                              .changeMunicipioId(municipioId!);
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
                          onChanged: (String? value) {
                            setState(() {
                              veredaId = value;
                            });

                            alianzaBeneficiarioCubit.changeVeredaId(veredaId!);
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
                        value: tipoTenenciaId != '' ? tipoTenenciaId : null,
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
                          alianzaBeneficiarioCubit.changeTipoTenencia(value);
                        },
                        hint: const Text('Tipo de tenencia'));
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: areaFincaCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Finca', labelText: 'Área Finca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeAreaFinca(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: areaProyectoCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Proyecto', labelText: 'Área Proyecto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeAreaProyecto(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Es asociado'),
                  value: alianzaBeneficiario.asociado == 'true' ? true : false,
                  onChanged: (bool? value) {
                    alianzaBeneficiarioCubit.changeAsociado(value);
                  }),
              SwitchListTile(
                  title: const Text('Está activo en la alianza'),
                  value: alianzaBeneficiario.activo == 'true' ? true : false,
                  onChanged: (bool? value) {
                    alianzaBeneficiarioCubit.changeActivo(value);
                  }),
              SwitchListTile(
                  title: const Text('Fue beneficiado'),
                  value: alianzaBeneficiario.fueBeneficiado == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    alianzaBeneficiarioCubit.changeFueBeneficiado(value);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: cualBeneficioCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Cuál Beneficio', labelText: 'Cuál Beneficio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    alianzaBeneficiarioCubit.changeCualBeneficio(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  controller: experienciaCtrl,
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
                    alianzaBeneficiarioCubit.changeExperiencia(newValue);
                  }),
            ],
          ),
        ),
      );
    }));
  }
}
