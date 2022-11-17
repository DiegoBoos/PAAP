import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class PerfilPreInversionAliadoForm extends StatelessWidget {
  const PerfilPreInversionAliadoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    return BlocBuilder<PerfilPreInversionAliadoCubit,
        PerfilPreInversionAliadoState>(builder: (context, state) {
      if (state is PerfilPreInversionAliadoLoading) {
        return const Center(
            heightFactor: 2, child: CircularProgressIndicator());
      }

      final perfilPreInversionAliado = state.perfilPreInversionAliado;

      return BlocBuilder<AliadoCubit, AliadoState>(
        builder: (context, state) {
          final aliado = state.aliado;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado?.aliadoId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID Aliado', labelText: 'ID Aliado')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado?.experiencia,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<DepartamentoCubit, DepartamentoState>(
                builder: (context, state) {
                  if (state is DepartamentosLoaded) {
                    return DropdownButtonFormField(
                        isExpanded: true,
                        items: state.departamentosLoaded!
                            .map<DropdownMenuItem<String>>(
                                (DepartamentoEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          municipioCubit.getMunicipiosByDepartamentoDB(value!);
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
                        items: state.municipiosLoaded!
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
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado?.nombreContacto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado?.direccion,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Dirección', labelText: 'Dirección')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado?.correo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado?.telefonoFijo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo')),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado?.telefonoMovil,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Móvil',
                            labelText: 'Teléfono Móvil')),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado?.fechaDesactivacion,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Fecha Desactivación',
                      labelText: 'Fecha Desactivación')),
              const SizedBox(height: 20),
              BlocBuilder<ProductoCubit, ProductoState>(
                builder: (context, state) {
                  if (state is ProductosLoaded) {
                    return DropdownButtonFormField(
                        items: state.productosLoaded!
                            .map<DropdownMenuItem<String>>(
                                (ProductoEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          perfilPreInversionAliadoCubit.changeProducto(value);
                        },
                        hint: const Text('Producto'));
                  }
                  return const SizedBox();
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: perfilPreInversionAliado?.volumenCompra,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo')),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<UnidadCubit, UnidadState>(
                      builder: (context, state) {
                        if (state is UnidadesLoaded) {
                          return DropdownButtonFormField(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            perfilPreInversionAliado?.porcentajeCompra,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Porcentaje de compra',
                            labelText: 'Porcentaje de compra')),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                      builder: (context, state) {
                        if (state is FrecuenciasLoaded) {
                          return DropdownButtonFormField(
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
              const SaveBackButtons(onSaved: null)
            ]),
          );
        },
      );
    });
  }
}
