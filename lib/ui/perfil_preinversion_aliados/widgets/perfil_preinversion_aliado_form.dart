import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
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

  @override
  void initState() {
    super.initState();
    loadAccesories();
  }

  @override
  void deactivate() {
    super.deactivate();
    municipioId = null;
    BlocProvider.of<PerfilPreInversionAliadoCubit>(context).initState();
    BlocProvider.of<AliadoCubit>(context).initState();
  }

  Future<void> loadAccesories() async {
    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    await municipioCubit.getMunicipiosDB();

    if (municipioCubit.state is MunicipiosLoaded) {
      municipiosFiltered = municipioCubit.state.municipios!;
    }

    if (aliadoCubit.state is AliadoLoaded) {
      final aliadoLoaded = aliadoCubit.state.aliado;

      loadAliado(aliadoLoaded);
    }
    if (perfilPreInversionAliadoCubit.state is PerfilPreInversionAliadoLoaded) {
      final perfilPreInversionAliadoLoaded =
          perfilPreInversionAliadoCubit.state.perfilPreInversionAliado;

      loadPerfilPreInversionAliado(perfilPreInversionAliadoLoaded);
    }
  }

  void loadAliado(AliadoEntity aliadoLoaded) {
    final aliadoMunicipioId = aliadoLoaded.municipioId;

    final municipio = municipiosFiltered.firstWhere(
        (municipio) => municipio.id == aliadoMunicipioId,
        orElse: () => MunicipioModel(id: '', nombre: '', departamentoid: ''));

    if (municipio.id != '') {
      departamentoId = municipio.departamentoid;
      municipioId = aliadoMunicipioId;
    }

    aliadoIdCtrl.text = aliadoLoaded.aliadoId;
    nombreCtrl.text = aliadoLoaded.nombre;
    experienciaCtrl.text = aliadoLoaded.experiencia;
    nombreContactoCtrl.text = aliadoLoaded.nombreContacto;
    direccionCtrl.text = aliadoLoaded.direccion;
    correoCtrl.text = aliadoLoaded.correo;
    telefonoFijoCtrl.text = aliadoLoaded.telefonoFijo;
    telefonoMovilCtrl.text = aliadoLoaded.telefonoMovil;
    fechaDesactivacionCtrl.text = aliadoLoaded.fechaDesactivacion;

    setState(() {});
  }

  void loadPerfilPreInversionAliado(
    PerfilPreInversionAliadoEntity perfilPreInversionAliadoLoaded,
  ) {
    volumenCompraCtrl.text = perfilPreInversionAliadoLoaded.volumenCompra;
    porcentajeCompraCtrl.text = perfilPreInversionAliadoLoaded.porcentajeCompra;
    productoId = perfilPreInversionAliadoLoaded.productoId;
    unidadId = perfilPreInversionAliadoLoaded.unidadId;
    frecuenciaId = perfilPreInversionAliadoLoaded.frecuenciaId;
    sitioEntregaId = perfilPreInversionAliadoLoaded.sitioEntregaId;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

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
          BlocListener<PerfilPreInversionAliadoCubit,
              PerfilPreInversionAliadoState>(
            listener: (context, state) {
              if (state is PerfilPreInversionAliadoError) {
                CustomSnackBar.showSnackBar(context, state.message, Colors.red);
              }

              if (state is PerfilPreInversionAliadoLoaded) {
                final perfilPreInversionAliadoLoaded =
                    state.perfilPreInversionAliadoLoaded;
                loadPerfilPreInversionAliado(perfilPreInversionAliadoLoaded);
              }
            },
          )
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
                        decoration:
                            const InputDecoration(label: Text('Departamento')),
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
                            municipiosFiltered = municipioCubit
                                .state.municipios!
                                .where(((municipio) =>
                                    municipio.departamentoid == value))
                                .toList();

                            departamentoId = value;
                            municipioId = null;
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
                        decoration:
                            const InputDecoration(label: Text('Municipio')),
                        items: municipiosFiltered.map<DropdownMenuItem<String>>(
                            (MunicipioEntity value) {
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
                        onSaved: (String? newValue) {
                          aliadoCubit.changeMunicipio(newValue);
                        },
                        hint: const Text('Municipio'));
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
                                value: productoId != '' ? productoId : null,
                                decoration: const InputDecoration(
                                    label: Text('Producto')),
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
                                      value: unidadId != '' ? unidadId : null,
                                      decoration: const InputDecoration(
                                          label: Text('Unidad')),
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
                                      value: frecuenciaId != ''
                                          ? frecuenciaId
                                          : null,
                                      decoration: const InputDecoration(
                                          label: Text('Frecuencia')),
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
                                value: sitioEntregaId != ''
                                    ? sitioEntregaId
                                    : null,
                                decoration: const InputDecoration(
                                    label: Text('Sitio de entrega')),
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
