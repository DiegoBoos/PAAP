import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../ui/cubits/departamento/departamento_cubit.dart';
import '../../../ui/cubits/municipio/municipio_cubit.dart';
import '../../../ui/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../ui/cubits/vereda/vereda_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/entities/vereda_entity.dart';
import '../../cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilBeneficiarioForm extends StatefulWidget {
  const PerfilBeneficiarioForm({super.key, required this.perfilBeneficiario});
  final PerfilBeneficiarioEntity? perfilBeneficiario;

  @override
  State<PerfilBeneficiarioForm> createState() => _PerfilBeneficiarioFormState();
}

class _PerfilBeneficiarioFormState extends State<PerfilBeneficiarioForm> {
  List<MunicipioEntity> allMunicipios = [];
  List<MunicipioEntity> municipiosFiltered = [];
  List<VeredaEntity> veredasFiltered = [];

  String? departamentoId;
  String? municipioId;
  String? veredaId;
  String? tipoTenenciaId;
  String? beneficioId;

  final areaFincaCtrl = TextEditingController();
  final areaProyectoCtrl = TextEditingController();
  final cualBeneficioCtrl = TextEditingController();
  final experienciaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    allMunicipios = municipioCubit.state.municipios!;
    municipiosFiltered = allMunicipios;

    loadPerfilBeneficiario(widget.perfilBeneficiario);
  }

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<PerfilBeneficiarioCubit>(context).initState();
  }

  void loadPerfilBeneficiario(PerfilBeneficiarioEntity? perfilBeneficiario) {
    setState(() {
      final perfilBeneficiarioMunicipioId = perfilBeneficiario?.municipioId;
      final perfilBeneficiarioVeredaId = perfilBeneficiario?.veredaId;

      final municipio = municipiosFiltered.firstWhere(
        (municipio) => municipio.id == perfilBeneficiarioMunicipioId,
      );

      if (municipio.id != '') {
        departamentoId = municipio.departamentoid;
        municipioId = perfilBeneficiarioMunicipioId;
        municipiosFiltered = allMunicipios
            .where((municipio) => municipio.departamentoid == departamentoId)
            .toList();
        loadVeredasByMunicipio(municipioId!, perfilBeneficiarioVeredaId!);
      }

      experienciaCtrl.text = perfilBeneficiario?.experiencia ?? '';
      cualBeneficioCtrl.text = perfilBeneficiario?.cualBeneficio ?? '';
      areaProyectoCtrl.text = perfilBeneficiario?.areaProyecto ?? '';
      areaFincaCtrl.text = perfilBeneficiario?.areaFinca ?? '';
      tipoTenenciaId = perfilBeneficiario?.tipoTenenciaId;
      beneficioId = perfilBeneficiario?.beneficioId;
    });
  }

  void loadVeredasByMunicipio(
      String municipioId, String perfilBeneficiarioVeredaId) async {
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    veredaCubit.getVeredasByMunicipioDB(municipioId);
    veredaId =
        perfilBeneficiarioVeredaId != '' ? perfilBeneficiarioVeredaId : null;
  }

  @override
  Widget build(BuildContext context) {
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context, listen: true);
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    return BlocBuilder<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
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
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Departamento', labelText: 'Departamento'),
                      isExpanded: true,
                      value: departamentoId,
                      items: state.departamentos!.map<DropdownMenuItem<String>>(
                          (DepartamentoEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
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
                        setState(() {
                          municipiosFiltered = allMunicipios
                              .where(((municipio) =>
                                  municipio.departamentoid == value))
                              .toList();

                          departamentoId = value;
                          municipioId = null;
                          veredaId = null;
                        });
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              if (departamentoId != null)
                BlocBuilder<MunicipioCubit, MunicipioState>(
                  builder: (context, state) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Municipio', labelText: 'Municipio'),
                      isExpanded: true,
                      value: municipioId,
                      items: municipiosFiltered.map<DropdownMenuItem<String>>(
                          (MunicipioEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre!),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
                      onChanged: (String? value) async {
                        veredaCubit.getVeredasByMunicipioDB(value!);

                        setState(() {
                          municipioId = value;
                          veredaId = null;
                        });

                        perfilBeneficiarioCubit.changeMunicipioId(municipioId!);
                      },
                    );
                  },
                ),
              if (municipioId != null) const SizedBox(height: 20),
              if (municipioId != null)
                BlocBuilder<VeredaCubit, VeredaState>(
                  builder: (context, state) {
                    if (state is VeredasLoaded) {
                      return DropdownButtonFormField(
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Vereda', labelText: 'Vereda'),
                        isExpanded: true,
                        value: veredaId,
                        items: state.veredasLoaded!
                            .map<DropdownMenuItem<String>>(
                                (VeredaEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.veredaId,
                            child: Text(value.nombre!),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            veredaId = value;
                          });

                          perfilBeneficiarioCubit.changeVeredaId(veredaId!);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              const SizedBox(height: 20),
              BlocBuilder<TipoTenenciaCubit, TipoTenenciaState>(
                builder: (context, state) {
                  if (state is TiposTenenciasLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Tipo Tenencia',
                          labelText: 'Tipo Tenencia'),
                      isExpanded: true,
                      value: tipoTenenciaId,
                      items: state.tiposTenencias!
                          .map<DropdownMenuItem<String>>(
                              (TipoTenenciaEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.tipoTenenciaId,
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
                        perfilBeneficiarioCubit.changeTipoTenencia(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: areaFincaCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Finca (Hectáreas)',
                      labelText: 'Área Finca (Hectáreas)'),
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
                  keyboardType: TextInputType.number,
                  controller: areaProyectoCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Área Proyecto (Hectáreas)',
                      labelText: 'Área Proyecto (Hectáreas)'),
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
                    perfilBeneficiarioCubit.changeAsociado(value.toString());
                  }),
              SwitchListTile(
                  title: const Text('Está activo en la alianza'),
                  value: perfilBeneficiario.activo == 'true' ? true : false,
                  onChanged: (bool? value) {
                    perfilBeneficiarioCubit.changeActivo(value.toString());
                  }),
              SwitchListTile(
                  title: const Text('Fue beneficiado'),
                  value: perfilBeneficiario.fueBeneficiado == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilBeneficiarioCubit
                        .changeFueBeneficiado(value.toString());
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
                    perfilBeneficiarioCubit.changeCualBeneficio(newValue);
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: experienciaCtrl,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Experiencia producto (Años)',
                      labelText: 'Experiencia producto (Años)'),
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
    });
  }
}
