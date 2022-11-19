import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/entities/aliado_entity.dart';
import 'package:paap/ui/utils/custom_snack_bar.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/cubits/departamento/departamento_cubit.dart';
import '../../../domain/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../../domain/cubits/producto/producto_cubit.dart';
import '../../../domain/cubits/sitio_entrega/sitio_entrega_cubit.dart';
import '../../../domain/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionAliadoForm extends StatefulWidget {
  const PerfilPreInversionAliadoForm({super.key});

  @override
  State<PerfilPreInversionAliadoForm> createState() =>
      _PerfilPreInversionAliadoFormState();
}

class _PerfilPreInversionAliadoFormState
    extends State<PerfilPreInversionAliadoForm> {
  final volumenCompraCtrl = TextEditingController();
  final porcentajeCompraCtrl = TextEditingController();
  final aliadoIdCtrl = TextEditingController();
  final experienciaCtrl = TextEditingController();
  final nombreContactoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final telefonoFijoCtrl = TextEditingController();
  final telefonoMovilCtrl = TextEditingController();
  final fechaDesactivacionCtrl = TextEditingController();

  String? departamentoId;
  String? municipioId;

  @override
  void initState() {
    super.initState();

    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);

    if (perfilPreInversionAliadoCubit.state is PerfilPreInversionAliadoLoaded) {
      final perfilPreInversionAliado =
          perfilPreInversionAliadoCubit.state.perfilPreInversionAliado!;

      volumenCompraCtrl.text = perfilPreInversionAliado.volumenCompra;
      porcentajeCompraCtrl.text = perfilPreInversionAliado.porcentajeCompra;
    }

    if (aliadoCubit.state is AliadoLoaded) {
      final aliado = aliadoCubit.state.aliado!;
      aliadoIdCtrl.text = aliado.aliadoId;
      experienciaCtrl.text = aliado.experiencia;
      nombreContactoCtrl.text = aliado.nombreContacto;
      direccionCtrl.text = aliado.direccion;
      correoCtrl.text = aliado.correo;
      telefonoFijoCtrl.text = aliado.telefonoFijo;
      telefonoMovilCtrl.text = aliado.telefonoMovil;
      fechaDesactivacionCtrl.text = aliado.fechaDesactivacion;

      loadDropdownDepartamento(aliadoCubit, aliado);
    }
  }

  void loadDropdownDepartamento(
      AliadoCubit aliadoCubit, AliadoEntity aliado) async {
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    final municipioIdAliado = aliadoCubit.state.aliado!.municipioId;

    final municipio = municipioCubit.state.municipios!
        .firstWhere((municipio) => municipio.id == municipioIdAliado);
    setState(() {
      departamentoId = municipio.departamentoid;
      municipioId = aliado.municipioId != '' ? aliado.municipioId : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<AliadoCubit, AliadoState>(
            listener: (context, state) {
              final aliado = state.aliado!;
              if (state is AliadoError) {
                CustomSnackBar.showSnackBar(context, state.message, Colors.red);
              }
              if (state is AliadoLoaded) {
                aliadoIdCtrl.text = aliado.aliadoId;
                experienciaCtrl.text = aliado.experiencia;
                nombreContactoCtrl.text = aliado.nombreContacto;
                direccionCtrl.text = aliado.direccion;
                correoCtrl.text = aliado.correo;
                telefonoFijoCtrl.text = aliado.telefonoFijo;
                telefonoMovilCtrl.text = aliado.telefonoMovil;
                fechaDesactivacionCtrl.text = aliado.fechaDesactivacion;
              }
            },
          ),
        ],
        child: BlocBuilder<PerfilPreInversionAliadoCubit,
            PerfilPreInversionAliadoState>(builder: (context, state) {
          final perfilPreInversionAliado = state.perfilPreInversionAliado;
          return BlocBuilder<AliadoCubit, AliadoState>(
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: aliadoIdCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'ID Aliado', labelText: 'ID Aliado'),
                            onFieldSubmitted: (String? newValue) {
                              aliadoCubit.selectAliado(newValue!);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            controller: experienciaCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Años de experiencia',
                                labelText: 'Años de experiencia'),
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
                            onChanged: (String? value) {
                              setState(() {
                                municipioId = null;
                              });
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
                            value: municipioId,
                            items: state.municipiosLoaded!
                                .map<DropdownMenuItem<String>>(
                                    (MunicipioEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                municipioId = value;
                              });
                              //veredaCubit.getVeredasByMunicipioDB(value!);
                            },
                            hint: const Text('Municipio'));
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: nombreContactoCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Nombre del contacto',
                          labelText: 'Nombre del contacto'),
                      onSaved: (String? newValue) {
                        aliadoCubit.changeNombreContacto(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: direccionCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Dirección', labelText: 'Dirección'),
                      onSaved: (String? newValue) {
                        aliadoCubit.changeDireccion(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: correoCtrl,
                      maxLines: null,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Correo', labelText: 'Correo'),
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
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Teléfono Fijo',
                                labelText: 'Teléfono Fijo'),
                            onSaved: (String? newValue) {
                              aliadoCubit.changeTelefonoFijo(newValue);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            controller: telefonoMovilCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Teléfono Móvil',
                                labelText: 'Teléfono Móvil'),
                            onSaved: (String? newValue) {
                              aliadoCubit.changeTelefonoMovil(newValue);
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: fechaDesactivacionCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Fecha Desactivación',
                          labelText: 'Fecha Desactivación'),
                      onSaved: (String? newValue) {
                        aliadoCubit.changeFechaDesactivacion(newValue);
                      }),
                  const SizedBox(height: 20),
                  BlocBuilder<ProductoCubit, ProductoState>(
                    builder: (context, state) {
                      if (state is ProductosLoaded) {
                        return DropdownButtonFormField(
                            value: perfilPreInversionAliado?.productoId != ''
                                ? perfilPreInversionAliado?.productoId
                                : null,
                            items: state.productosLoaded!
                                .map<DropdownMenuItem<String>>(
                                    (ProductoEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              perfilPreInversionAliadoCubit
                                  .changeProducto(value);
                            },
                            hint: const Text('Producto'));
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
                            controller: volumenCompraCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Volumen Compra',
                                labelText: 'Volumen Compra'),
                            onSaved: (String? newValue) {
                              aliadoCubit.changeVolumenCompra(newValue);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: BlocBuilder<UnidadCubit, UnidadState>(
                          builder: (context, state) {
                            if (state is UnidadesLoaded) {
                              return DropdownButtonFormField(
                                  value:
                                      perfilPreInversionAliado?.unidadId != ''
                                          ? perfilPreInversionAliado?.unidadId
                                          : null,
                                  items: state.unidadesLoaded!
                                      .map<DropdownMenuItem<String>>(
                                          (UnidadEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.unidadId,
                                      child: Text(value.nombre),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    perfilPreInversionAliadoCubit
                                        .changeUnidad(value);
                                  },
                                  hint: const Text('Unidad'));
                            }
                            return const SizedBox();
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
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Porcentaje de compra',
                                labelText: 'Porcentaje de compra'),
                            onSaved: (String? newValue) {
                              aliadoCubit.changePorcentajeCompra(newValue);
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                          builder: (context, state) {
                            if (state is FrecuenciasLoaded) {
                              return DropdownButtonFormField(
                                  value: perfilPreInversionAliado
                                              ?.frecuenciaId !=
                                          ''
                                      ? perfilPreInversionAliado?.frecuenciaId
                                      : null,
                                  items: state.frecuenciasLoaded!
                                      .map<DropdownMenuItem<String>>(
                                          (FrecuenciaEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.frecuenciaId,
                                      child: Text(value.nombre),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    perfilPreInversionAliadoCubit
                                        .changeFrecuencia(value);
                                  },
                                  hint: const Text('Frecuencia'));
                            }
                            return const SizedBox();
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
                            value:
                                perfilPreInversionAliado?.sitioEntregaId != ''
                                    ? perfilPreInversionAliado?.sitioEntregaId
                                    : null,
                            items: state.sitiosEntregasLoaded!
                                .map<DropdownMenuItem<String>>(
                                    (SitioEntregaEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.sitioEntregaId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              perfilPreInversionAliadoCubit
                                  .changeSitioEntrega(value);
                            },
                            hint: const Text('SitioEntrega'));
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20),
                  SaveBackButtons(onSaved: () {
                    //TODO: Guardar en tabla aliados, perfil preinversion aliados,
                    final aliado = aliadoCubit.state.aliado;
                    final perfilPreInversionAliado =
                        perfilPreInversionAliadoCubit
                            .state.perfilPreInversionAliado;
                  })
                ]),
              );
            },
          );
        }));
  }
}
