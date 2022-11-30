import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/entities/actividad_financiera_entity.dart';
import 'package:paap/domain/usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';

import '../../../domain/cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import '../../../domain/cubits/producto/producto_cubit.dart';
import '../../../domain/cubits/rubro/rubro_cubit.dart';
import '../../../domain/cubits/tipo_calidad/tipo_calidad_cubit.dart';
import '../../../domain/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/actividad_entity.dart';
import '../../../domain/entities/producto_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/tipo_calidad_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class IngresosUPTForm extends StatefulWidget {
  const IngresosUPTForm(this.actividadesFinancieras, {super.key});

  final List<ActividadFinancieraEntity> actividadesFinancieras;

  @override
  State<IngresosUPTForm> createState() => _IngresosUPTFormState();
}

class _IngresosUPTFormState extends State<IngresosUPTForm> {
  @override
  Widget build(BuildContext context) {
    final perfilPreInversionPlanNegocioCubit =
        BlocProvider.of<PerfilPreInversionPlanNegocioCubit>(context);
    final perfilPreInversionPlanNegocio =
        perfilPreInversionPlanNegocioCubit.state.perfilPreInversionPlanNegocio;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(children: [
          const Text(
            'Ingresos UPT',
            style: Styles.titleStyle,
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Precio Por Calidad Asignada',
                    style: Styles.titleStyle,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ProductoCubit, ProductoState>(
                    builder: (context, state) {
                      if (state is ProductosLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: state.productos!
                                .map<DropdownMenuItem<String>>(
                                    (ProductoEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: const Text('Unidad'));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<TipoCalidadCubit, TipoCalidadState>(
                    builder: (context, state) {
                      if (state is ProductosLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: state.tiposCalidades!
                                .map<DropdownMenuItem<String>>(
                                    (TipoCalidadEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.tipoCalidadId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: const Text('Tipo Calidad'));
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
                              initialValue:
                                  state.perfilPreInversionPrecio.precio,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Precio', labelText: 'Precio')),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                                heroTag: 'btn-add-precio',
                                onPressed: () {},
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                child: const Icon(Icons.add)),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Cantidad Esperada Por Año',
                      style: Styles.titleStyle),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                      isExpanded: true,
                      items: widget.actividadesFinancieras
                          .where((actividadFinanciera) =>
                              actividadFinanciera.tipoMovimientoId == '3')
                          .map<DropdownMenuItem<String>>(
                              (ActividadFinancieraEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.actividadFinancieraId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {},
                      hint: const Text('Actividad Financiera')),
                  const SizedBox(height: 20),
                  BlocBuilder<RubroCubit, RubroState>(
                    builder: (context, state) {
                      if (state is RubrosLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: state.rubros!.map<DropdownMenuItem<String>>(
                                (RubroEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.rubroId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: const Text('Rubro'));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UnidadCubit, UnidadState>(
                    builder: (context, state) {
                      if (state is UnidadesLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: state.unidades!
                                .map<DropdownMenuItem<String>>(
                                    (UnidadEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.unidadId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {},
                            hint: const Text('Unidad'));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: perfilPreInversionPlanNegocio.year,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Año', labelText: 'Año')),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: perfilPreInversionPlanNegocio.cantidad,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cantidad', labelText: 'Cantidad')),
                  TextFormField(
                      initialValue: perfilPreInversionPlanNegocio.valor,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Valor', labelText: 'Valor')),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      heroTag: 'btn-add-cantidad',
                      onPressed: () {},
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SaveBackButtons(
            onSaved: null,
            routeName: 'tabs',
          )
        ]));
  }
}
