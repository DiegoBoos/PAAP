import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/municipio_model.dart';
import '../../../ui/cubits/aliado/aliado_cubit.dart';
import '../../../ui/cubits/departamento/departamento_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/municipio/municipio_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../../ui/cubits/producto/producto_cubit.dart';
import '../../../ui/cubits/sitio_entrega/sitio_entrega_cubit.dart';
import '../../../ui/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionAliadoForm extends StatefulWidget {
  const PerfilPreInversionAliadoForm(
      {super.key, this.perfilPreInversionAliado});

  final PerfilPreInversionAliadoEntity? perfilPreInversionAliado;

  @override
  State<PerfilPreInversionAliadoForm> createState() =>
      _PerfilPreInversionAliadoFormState();
}

class _PerfilPreInversionAliadoFormState
    extends State<PerfilPreInversionAliadoForm> {
  List<MunicipioEntity> allMunicipios = [];
  List<MunicipioEntity> municipiosFiltered = [];

  String? departamentoId;
  String? municipioId;
  String? productoId;
  String? unidadId;
  String? frecuenciaId;
  String? sitioEntregaId;

  final aliadoIdCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final experienciaCtrl = TextEditingController();
  final nombreContactoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final telefonoFijoCtrl = TextEditingController();
  final telefonoMovilCtrl = TextEditingController();
  final fechaDesactivacionCtrl = TextEditingController();
  final volumenCompraCtrl = TextEditingController();
  final porcentajeCompraCtrl = TextEditingController();

  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();

    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    allMunicipios = municipioCubit.state.municipios!;
    municipiosFiltered = allMunicipios;

    setState(() {
      volumenCompraCtrl.text =
          widget.perfilPreInversionAliado?.volumenCompra ?? '';
      porcentajeCompraCtrl.text =
          widget.perfilPreInversionAliado?.porcentajeCompra ?? '';
      productoId = widget.perfilPreInversionAliado?.productoId;
      unidadId = widget.perfilPreInversionAliado?.unidadId;
      frecuenciaId = widget.perfilPreInversionAliado?.frecuenciaId;
      sitioEntregaId = widget.perfilPreInversionAliado?.sitioEntregaId;
    });

    loadAliado(aliadoCubit.state.aliado);
  }

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<PerfilPreInversionAliadoCubit>(context).initState();
    BlocProvider.of<AliadoCubit>(context).initState();
  }

  loadAliado(AliadoEntity aliado) {
    setState(() {
      final aliadoMunicipioId = aliado.municipioId;

      final municipio = municipiosFiltered.firstWhere(
          (municipio) => municipio.id == aliadoMunicipioId,
          orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

      if (municipio.id != '') {
        departamentoId = municipio.departamentoid;
        municipioId = aliadoMunicipioId;

        municipiosFiltered = allMunicipios
            .where(((municipio) => municipio.departamentoid == departamentoId))
            .toList();
      }
      aliadoIdCtrl.text = aliado.aliadoId ?? '';
      nombreCtrl.text = aliado.nombre ?? '';
      experienciaCtrl.text = aliado.experiencia ?? '';
      nombreContactoCtrl.text = aliado.nombreContacto ?? '';
      direccionCtrl.text = aliado.direccion ?? '';
      correoCtrl.text = aliado.correo ?? '';
      telefonoFijoCtrl.text = aliado.telefonoFijo ?? '';
      telefonoMovilCtrl.text = aliado.telefonoMovil ?? '';

      if (aliado.fechaDesactivacion != null &&
          aliado.fechaDesactivacion != '') {
        fechaDesactivacionCtrl.text =
            dateFormat.format(DateTime.parse(aliado.fechaDesactivacion!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<AliadoCubit, AliadoState>(listener: ((context, state) {
            if (state is AliadoError) {
              CustomSnackBar.showSnackBar(context, state.message, Colors.red);
            }

            if (state is AliadoLoaded) {
              final aliadoLoaded = state.aliadoLoaded;
              loadAliado(aliadoLoaded);
            }
          })),
        ],
        child: BlocBuilder<AliadoCubit, AliadoState>(
          builder: (context, state) {
            return Column(children: [
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
                      onFieldSubmitted: (String? newValue) {
                        aliadoCubit.getAliado(newValue!);
                      },
                      onSaved: (String? newValue) {
                        aliadoCubit.changeAliadoId(newValue);
                        perfilPreInversionAliadoCubit.changeAliadoId(newValue);
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
              BlocBuilder<DepartamentoCubit, DepartamentoState>(
                builder: (context, state) {
                  if (state is DepartamentosLoaded) {
                    return DropdownButtonFormField(
                      isExpanded: true,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Departamento', labelText: 'Departamento'),
                      value: departamentoId,
                      items: state.departamentosLoaded!
                          .map<DropdownMenuItem<String>>(
                              (DepartamentoEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre!),
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
                          municipiosFiltered = allMunicipios
                              .where(((municipio) =>
                                  municipio.departamentoid == value))
                              .toList();

                          departamentoId = value;
                          municipioId = null;
                        });
                      },
                    );
                  }
                  return Container();
                },
              ),
              if (departamentoId != null) const SizedBox(height: 20),
              if (departamentoId != null)
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Municipio', labelText: 'Municipio'),
                  value: municipioId,
                  items: municipiosFiltered
                      .map<DropdownMenuItem<String>>((MunicipioEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.nombre!),
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
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo'),
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

                          fechaDesactivacionCtrl.text =
                              dateFormat.format(newDate);
                        },
                        icon: const Icon(Icons.calendar_today))),
              ),
              const SizedBox(height: 20),
              BlocBuilder<PerfilPreInversionAliadoCubit,
                  PerfilPreInversionAliadoState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      BlocBuilder<ProductoCubit, ProductoState>(
                        builder: (context, state) {
                          if (state is ProductosLoaded) {
                            return DropdownButtonFormField(
                              isExpanded: true,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Producto', labelText: 'Producto'),
                              value: productoId,
                              items: state.productosLoaded!
                                  .map<DropdownMenuItem<String>>(
                                      (ProductoEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(value.nombre!),
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
                                controller: volumenCompraCtrl,
                                keyboardType: TextInputType.number,
                                decoration:
                                    CustomInputDecoration.inputDecoration(
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
                                    isExpanded: true,
                                    decoration:
                                        CustomInputDecoration.inputDecoration(
                                            hintText: 'Unidad',
                                            labelText: 'Unidad'),
                                    value: unidadId,
                                    items: state.unidadesLoaded!
                                        .map<DropdownMenuItem<String>>(
                                            (UnidadEntity value) {
                                      return DropdownMenuItem<String>(
                                        value: value.unidadId,
                                        child: Text(value.nombre!),
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
                                  );
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
                                controller: porcentajeCompraCtrl,
                                keyboardType: TextInputType.number,
                                decoration:
                                    CustomInputDecoration.inputDecoration(
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
                            child:
                                BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                              builder: (context, state) {
                                if (state is FrecuenciasLoaded) {
                                  return DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration:
                                        CustomInputDecoration.inputDecoration(
                                            hintText: 'Frecuencia',
                                            labelText: 'Frecuencia'),
                                    value: frecuenciaId,
                                    items: state.frecuenciasLoaded!
                                        .map<DropdownMenuItem<String>>(
                                            (FrecuenciaEntity value) {
                                      return DropdownMenuItem<String>(
                                        value: value.frecuenciaId,
                                        child: Text(value.nombre!),
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
                                  );
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
                              isExpanded: true,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Sitio Entrega',
                                  labelText: 'Sitio Entrega'),
                              value: sitioEntregaId,
                              items: state.sitiosEntregasLoaded!
                                  .map<DropdownMenuItem<String>>(
                                      (SitioEntregaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.sitioEntregaId,
                                  child: Text(value.nombre!),
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
                            );
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
