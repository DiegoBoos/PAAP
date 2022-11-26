import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/municipio_model.dart';
import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../../domain/cubits/producto/producto_cubit.dart';
import '../../../domain/cubits/sitio_entrega/sitio_entrega_cubit.dart';
import '../../../domain/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionAliadoForm extends StatefulWidget {
  const PerfilPreInversionAliadoForm(this.formKey, {super.key});
  final GlobalKey<FormState> formKey;

  @override
  State<PerfilPreInversionAliadoForm> createState() =>
      _PerfilPreInversionAliadoFormState();
}

class _PerfilPreInversionAliadoFormState
    extends State<PerfilPreInversionAliadoForm> {
  List<MunicipioEntity> municipios = [];
  List<MunicipioEntity> municipiosFiltered = [];

  String? departamentoId;
  String? municipioId;

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<PerfilPreInversionAliadoCubit>(context).initState();
    BlocProvider.of<AliadoCubit>(context).initState();
  }

  @override
  void initState() {
    super.initState();
    loadMunicipios();
  }

  Future<void> loadMunicipios() async {
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    if (aliadoCubit.state is AliadoLoaded) {
      final aliado = aliadoCubit.state.aliado;
      await municipioCubit.getMunicipiosDB();
      municipiosFiltered = municipioCubit.state.municipios!;
      loadDepartamentoMunicipio(aliado);
    }
  }

  void loadDepartamentoMunicipio(AliadoEntity aliadoChanged) {
    final municipioIdAliado = aliadoChanged.municipioId;

    final municipio = municipiosFiltered.firstWhere(
        (municipio) => municipio.id == municipioIdAliado,
        orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

    if (municipio.id != '') {
      setState(() {
        departamentoId = municipio.departamentoid;
        municipioId =
            aliadoChanged.municipioId != '' ? aliadoChanged.municipioId : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);

    return BlocListener<AliadoCubit, AliadoState>(listener: (context, state) {
      if (state is AliadoError) {
        CustomSnackBar.showSnackBar(context, state.message, Colors.red);
      }

      if (state is AliadoChanged) {
        final aliadoChanged = state.aliadoChanged;

        loadDepartamentoMunicipio(aliadoChanged);
      }
    }, child: BlocBuilder<AliadoCubit, AliadoState>(
      builder: (context, state) {
        final aliado = state.aliado;
        return Column(children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                    key: UniqueKey(),
                    initialValue: aliado.aliadoId,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'ID Aliado', labelText: 'ID Aliado'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Requerido*';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String? newValue) {
                      aliadoCubit.selectAliado(newValue!);
                    }),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                    key: UniqueKey(),
                    initialValue: aliado.experiencia,
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
          BlocBuilder<DepartamentoCubit, DepartamentoState>(
            builder: (context, state) {
              if (state is DepartamentosLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    value: departamentoId,
                    items: state.departamentosLoaded!
                        .map<DropdownMenuItem<String>>(
                            (DepartamentoEntity value) {
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
                        municipiosFiltered = municipios
                            .where(((municipio) =>
                                municipio.departamentoid == value))
                            .toList();

                        municipioId = null;
                      });
                    },
                    hint: const Text('Departamento'));
              }
              return Container();
            },
          ),
          BlocBuilder<MunicipioCubit, MunicipioState>(
            builder: (context, state) {
              if (state is MunicipiosLoaded) {
                municipios = state.municipiosLoaded!;

                municipiosFiltered = municipios;
                return DropdownButtonFormField(
                    isExpanded: true,
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
                    hint: const Text('Municipio'));
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              key: UniqueKey(),
              initialValue: aliado.nombreContacto,
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
              key: UniqueKey(),
              initialValue: aliado.direccion,
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
              key: UniqueKey(),
              initialValue: aliado.correo,
              maxLines: null,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Correo', labelText: 'Correo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
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
                    key: UniqueKey(),
                    initialValue: aliado.telefonoFijo,
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
                    key: UniqueKey(),
                    initialValue: aliado.telefonoMovil,
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
              key: UniqueKey(),
              initialValue: aliado.fechaDesactivacion,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Fecha Desactivación',
                  labelText: 'Fecha Desactivación'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido*';
                }
                return null;
              },
              onSaved: (String? newValue) {
                aliadoCubit.changeFechaDesactivacion(newValue);
              }),
          const SizedBox(height: 20),
          BlocBuilder<PerfilPreInversionAliadoCubit,
              PerfilPreInversionAliadoState>(
            builder: (context, state) {
              final perfilPreInversionAliado = state.perfilPreInversionAliado;

              return Column(
                children: [
                  BlocBuilder<ProductoCubit, ProductoState>(
                    builder: (context, state) {
                      if (state is ProductosLoaded) {
                        return DropdownButtonFormField(
                            value: perfilPreInversionAliado.productoId != ''
                                ? perfilPreInversionAliado.productoId
                                : null,
                            items: state.productosLoaded!
                                .map<DropdownMenuItem<String>>(
                                    (ProductoEntity value) {
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
                              perfilPreInversionAliadoCubit
                                  .changeProducto(value);
                            },
                            hint: const Text('Producto'));
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
                                perfilPreInversionAliado.volumenCompra,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Volumen Compra',
                                labelText: 'Volumen Compra'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo Requerido*';
                              }
                              return null;
                            },
                            onSaved: (String? newValue) {
                              perfilPreInversionAliadoCubit
                                  .changeVolumenCompra(newValue);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: BlocBuilder<UnidadCubit, UnidadState>(
                          builder: (context, state) {
                            if (state is UnidadesLoaded) {
                              return DropdownButtonFormField(
                                  value: perfilPreInversionAliado.unidadId != ''
                                      ? perfilPreInversionAliado.unidadId
                                      : null,
                                  items: state.unidadesLoaded!
                                      .map<DropdownMenuItem<String>>(
                                          (UnidadEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.unidadId,
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
                                    perfilPreInversionAliadoCubit
                                        .changeUnidad(value);
                                  },
                                  hint: const Text('Unidad'));
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            key: UniqueKey(),
                            initialValue:
                                perfilPreInversionAliado.porcentajeCompra,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Porcentaje de compra',
                                labelText: 'Porcentaje de compra'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo Requerido*';
                              }
                              return null;
                            },
                            onSaved: (String? newValue) {
                              perfilPreInversionAliadoCubit
                                  .changePorcentajeCompra(newValue);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                          builder: (context, state) {
                            if (state is FrecuenciasLoaded) {
                              return DropdownButtonFormField(
                                  value: perfilPreInversionAliado
                                              .frecuenciaId !=
                                          ''
                                      ? perfilPreInversionAliado.frecuenciaId
                                      : null,
                                  items: state.frecuenciasLoaded!
                                      .map<DropdownMenuItem<String>>(
                                          (FrecuenciaEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.frecuenciaId,
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
                                    perfilPreInversionAliadoCubit
                                        .changeFrecuencia(value);
                                  },
                                  hint: const Text('Frecuencia'));
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<SitioEntregaCubit, SitioEntregaState>(
                    builder: (context, state) {
                      if (state is SitiosEntregasLoaded) {
                        return DropdownButtonFormField(
                            value: perfilPreInversionAliado.sitioEntregaId != ''
                                ? perfilPreInversionAliado.sitioEntregaId
                                : null,
                            items: state.sitiosEntregasLoaded!
                                .map<DropdownMenuItem<String>>(
                                    (SitioEntregaEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.sitioEntregaId,
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
                              perfilPreInversionAliadoCubit
                                  .changeSitioEntrega(value);
                            },
                            hint: const Text('SitioEntrega'));
                      }
                      return Container();
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
        ]);
      },
    ));
  }
}
