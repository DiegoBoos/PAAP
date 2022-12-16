import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/municipio_model.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/tipo_tenencia/tipo_tenencia_cubit.dart';
import '../../../domain/cubits/vereda/vereda_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
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
  String? tipoTenenciaId;

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
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  Future<void> loadAccesories() async {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    await municipioCubit.getMunicipiosDB();

    if (municipioCubit.state is MunicipiosLoaded) {
      municipiosFiltered = municipioCubit.state.municipios!;
    }

    if (perfilPreInversionBeneficiarioCubit.state
        is PerfilPreInversionBeneficiarioLoaded) {
      final perfilPreInversionBeneficiarioLoaded =
          perfilPreInversionBeneficiarioCubit
              .state.perfilPreInversionBeneficiario;

      loadPerfilPreInversionBeneficiario(perfilPreInversionBeneficiarioLoaded);
    }
  }

  void loadPerfilPreInversionBeneficiario(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioLoaded) {
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final perfilPreInversionBeneficiarioMunicipioId =
        perfilPreInversionBeneficiarioLoaded.municipioId;
    final perfilPreInversionBeneficiarioVeredaId =
        perfilPreInversionBeneficiarioLoaded.veredaId;

    final municipio = municipiosFiltered.firstWhere(
        (municipio) =>
            municipio.id == perfilPreInversionBeneficiarioMunicipioId,
        orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

    if (municipio.id != '') {
      departamentoId = municipio.departamentoid;
      municipioId = perfilPreInversionBeneficiarioMunicipioId;
      municipiosFiltered = municipioCubit.state.municipios!
          .where((municipio) => municipio.departamentoid == departamentoId)
          .toList();
      loadVeredasByMunicipio(
          municipioId!, perfilPreInversionBeneficiarioVeredaId);
    }

    experienciaCtrl.text = perfilPreInversionBeneficiarioLoaded.experiencia;
    cualBeneficioCtrl.text = perfilPreInversionBeneficiarioLoaded.cualBeneficio;
    areaProyectoCtrl.text = perfilPreInversionBeneficiarioLoaded.areaProyecto;
    areaFincaCtrl.text = perfilPreInversionBeneficiarioLoaded.areaFinca;
    tipoTenenciaId = perfilPreInversionBeneficiarioLoaded.tipoTenenciaId;

    setState(() {});
  }

  void loadVeredasByMunicipio(
      String municipioId, String perfilPreInversionBeneficiarioVeredaId) async {
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    await veredaCubit.getVeredasByMunicipioDB(municipioId);
    veredaId = perfilPreInversionBeneficiarioVeredaId != ''
        ? perfilPreInversionBeneficiarioVeredaId
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context,
            listen: true);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    final veredaCubit = BlocProvider.of<VeredaCubit>(context);

    final perfilPreInversionBeneficiario = perfilPreInversionBeneficiarioCubit
        .state.perfilPreInversionBeneficiario;

    return BlocListener<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(listener: (context, state) {
      if (state is PerfilPreInversionBeneficiarioError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }

      if (state is PerfilPreInversionBeneficiarioLoaded) {
        final perfilPreInversionBeneficiarioLoaded =
            state.perfilPreInversionBeneficiarioLoaded;
        loadPerfilPreInversionBeneficiario(
            perfilPreInversionBeneficiarioLoaded);
      }
    }, child: BlocBuilder<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(builder: (context, state) {
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
                          municipiosFiltered = municipioCubit.state.municipios!
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
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Campo Requerido';
                        }
                        return null;
                      },
                      onChanged: (String? value) async {
                        await veredaCubit.getVeredasByMunicipioDB(value!);

                        setState(() {
                          municipioId = value;
                          veredaId = null;
                        });

                        perfilPreInversionBeneficiarioCubit
                            .changeMunicipioId(municipioId!);
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
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            veredaId = value;
                          });

                          perfilPreInversionBeneficiarioCubit
                              .changeVeredaId(veredaId!);
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
                            .changeTipoTenencia(value);
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
                    perfilPreInversionBeneficiarioCubit
                        .changeAreaFinca(newValue);
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
                    perfilPreInversionBeneficiarioCubit
                        .changeAreaProyecto(newValue);
                  }),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Es asociado'),
                  value: perfilPreInversionBeneficiario.asociado == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilPreInversionBeneficiarioCubit
                        .changeAsociado(value.toString());
                  }),
              SwitchListTile(
                  title: const Text('Está activo en la alianza'),
                  value: perfilPreInversionBeneficiario.activo == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilPreInversionBeneficiarioCubit
                        .changeActivo(value.toString());
                  }),
              SwitchListTile(
                  title: const Text('Fue beneficiado'),
                  value: perfilPreInversionBeneficiario.fueBeneficiado == 'true'
                      ? true
                      : false,
                  onChanged: (bool? value) {
                    perfilPreInversionBeneficiarioCubit
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
                    perfilPreInversionBeneficiarioCubit
                        .changeCualBeneficio(newValue);
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
                    perfilPreInversionBeneficiarioCubit
                        .changeExperiencia(newValue);
                  }),
            ],
          ),
        ),
      );
    }));
  }
}
