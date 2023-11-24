import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../ui/blocs/perfiles_preinversiones_precios/perfiles_preinversiones_precios_bloc.dart';
import '../../../ui/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import '../../../ui/cubits/producto/producto_cubit.dart';
import '../../../ui/cubits/tipo_calidad/tipo_calidad_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/tipo_calidad_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/sync_pages.dart';
import '../../utils/styles.dart';

class PerfilPreInversionPrecioForm extends StatefulWidget {
  const PerfilPreInversionPrecioForm({
    Key? key,
  }) : super(key: key);

  @override
  State<PerfilPreInversionPrecioForm> createState() =>
      _PerfilPreInversionPrecioFormState();
}

class _PerfilPreInversionPrecioFormState
    extends State<PerfilPreInversionPrecioForm> {
  final formKeyPerfilPreInversionPrecio = GlobalKey<FormState>();
  String? productoId;
  String? tipoCalidadId;
  final precioCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAccesories();
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionPrecioCubit>(context).initState();
    BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context).initState();
  }

  Future<void> loadAccesories() async {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionPrecioCubit =
        BlocProvider.of<PerfilPreInversionPrecioCubit>(context);

    final productoCubit = BlocProvider.of<ProductoCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    final perfilPreInversionPrecio =
        perfilPreInversionPrecioCubit.state.perfilPreInversionPrecio;

    productoCubit.getProductosDB(perfilPreInversionId);

    setState(() {
      productoId = perfilPreInversionPrecio.productoId;
      tipoCalidadId = perfilPreInversionPrecio.tipoCalidadId;
      precioCtrl.text = perfilPreInversionPrecio.precio ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionPrecioCubit =
        BlocProvider.of<PerfilPreInversionPrecioCubit>(context);

    final perfilPreInversionIngresosUPTCubit =
        BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context);

    final perfilesPreInversionesPreciosBloc =
        BlocProvider.of<PerfilesPreInversionesPreciosBloc>(
      context,
    );

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    return BlocListener<PerfilesPreInversionesPreciosBloc,
        PerfilesPreInversionesPreciosState>(
      listener: (context, state) {
        if (state is PerfilesPreInversionesPreciosSaved) {
          perfilesPreInversionesPreciosBloc
              .add(GetPerfilesPreInversionesPrecios(perfilPreInversionId));
        }
      },
      child: Form(
        key: formKeyPerfilPreInversionPrecio,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Precio Por Calidad Asignada',
                  style: Styles.titleStyle,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                BlocBuilder<ProductoCubit, ProductoState>(
                  builder: (context, state) {
                    if (state is ProductosLoaded) {
                      return DropdownButtonFormField(
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Producto', labelText: 'Producto'),
                        isExpanded: true,
                        value: productoId,
                        items: state.productos!.map<DropdownMenuItem<String>>(
                            (ProductoEntity value) {
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
                          perfilPreInversionIngresosUPTCubit
                              .changeProducto(value);
                          perfilPreInversionPrecioCubit.changeProducto(value);
                        },
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<TipoCalidadCubit, TipoCalidadState>(
                  builder: (context, state) {
                    if (state is TiposCalidadesLoaded) {
                      return DropdownButtonFormField(
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Tipo Calidad',
                            labelText: 'Tipo Calidad'),
                        isExpanded: true,
                        value: tipoCalidadId,
                        items: state.tiposCalidades!
                            .map<DropdownMenuItem<String>>(
                                (TipoCalidadEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.tipoCalidadId,
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
                          perfilPreInversionIngresosUPTCubit
                              .changeTipoCalidad(value);
                          perfilPreInversionPrecioCubit
                              .changeTipoCalidad(value);
                        },
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<PerfilPreInversionPrecioCubit,
                    PerfilPreInversionPrecioState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.number,
                            controller: precioCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Precio', labelText: 'Precio'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo Requerido';
                              }
                              return null;
                            },
                            onSaved: (String? newValue) {
                              perfilPreInversionPrecioCubit
                                  .changePrecio(newValue);
                            }),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                              heroTag: 'btn-add-precio',
                              onPressed: () async {
                                if (!formKeyPerfilPreInversionPrecio
                                    .currentState!
                                    .validate()) {
                                  return;
                                }

                                formKeyPerfilPreInversionPrecio.currentState!
                                    .save();

                                final perfilPreInversionId =
                                    vPerfilPreInversionCubit
                                        .state
                                        .vPerfilPreInversion!
                                        .perfilPreInversionId!;

                                perfilPreInversionPrecioCubit
                                    .changePerfilPreInversionId(
                                        perfilPreInversionId);

                                perfilPreInversionPrecioCubit
                                    .savePerfilPreInversionPrecioDB();
                              },
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: const Icon(Icons.add)),
                        ),
                        const PerfilesPreInversionesPreciosRows()
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PerfilesPreInversionesPreciosRows extends StatefulWidget {
  const PerfilesPreInversionesPreciosRows({
    Key? key,
  }) : super(key: key);

  @override
  State<PerfilesPreInversionesPreciosRows> createState() =>
      _PerfilesPreInversionesPreciosRowsState();
}

class _PerfilesPreInversionesPreciosRowsState
    extends State<PerfilesPreInversionesPreciosRows> {
  @override
  void initState() {
    super.initState();

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilesPreInversionesPreciosBloc =
        BlocProvider.of<PerfilesPreInversionesPreciosBloc>(context);

    perfilesPreInversionesPreciosBloc.add(GetPerfilesPreInversionesPrecios(
        vPerfilPreInversionCubit
            .state.vPerfilPreInversion!.perfilPreInversionId!));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PerfilesPreInversionesPreciosBloc>(context, listen: true);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<PerfilesPreInversionesPreciosBloc,
          PerfilesPreInversionesPreciosState>(builder: (context, state) {
        if (state is PerfilesPreInversionesPreciosLoading) {
          return const CustomCircularProgress(alignment: Alignment.center);
        }
        if (state is PerfilesPreInversionesPreciosLoaded) {
          final perfilesPreInversionesPrecios =
              state.perfilesPreInversionesPrecios!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DataTable(
              columnSpacing: 30,
              headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              columns: <DataColumn>[
                //DataColumn(label: Container()),
                DataColumn(
                  label: Expanded(
                    child: Text('Id',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Unidad',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Producto',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Tipo Calidad',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Precio',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ],
              rows:
                  List.generate(perfilesPreInversionesPrecios.length, (index) {
                PerfilPreInversionPrecioEntity perfilPreInversionPrecio =
                    perfilesPreInversionesPrecios[index];

                final precio = NumberFormat.currency(
                        locale: 'en_US', decimalDigits: 0, symbol: "\$")
                    .format(double.parse(perfilPreInversionPrecio.precio!));

                return DataRow(cells: <DataCell>[
                  DataCell(
                      Text(perfilPreInversionPrecio.perfilPreInversionId!)),
                  DataCell(Text(perfilPreInversionPrecio.unidad ?? '')),
                  DataCell(Text(perfilPreInversionPrecio.producto ?? '')),
                  DataCell(Text(perfilPreInversionPrecio.tipoCalidad ?? '')),
                  DataCell(Text(precio)),
                ]);
              }),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
