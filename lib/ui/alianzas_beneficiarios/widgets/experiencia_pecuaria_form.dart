import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ExperienciaPecuariaForm extends StatefulWidget {
  const ExperienciaPecuariaForm(this.alianzaExperienciaPecuaria, {super.key});
  final AlianzaExperienciaPecuariaEntity? alianzaExperienciaPecuaria;

  @override
  State<ExperienciaPecuariaForm> createState() =>
      _ExperienciaPecuariaFormState();
}

class _ExperienciaPecuariaFormState extends State<ExperienciaPecuariaForm> {
  String? alianzaExperienciaAgricolaTipoActividadProductivaId;
  String? alianzaExperienciaAgricolaFrecuenciaId;

  final areaCultivoCtrl = TextEditingController();
  final cantidadProducidaCtrl = TextEditingController();
  final cantidadVendidaCtrl = TextEditingController();
  final cantidadAutoconsumoCtrl = TextEditingController();
  final costoImplementacionCtrl = TextEditingController();
  final alianzaExperienciaAgricolaValorJornalCtrl = TextEditingController();
  final totalIngresoNetoCtrl = TextEditingController();
  final areaPastoCtrl = TextEditingController();
  final areaSinUsoCtrl = TextEditingController();
  final areaReservaConservacionCtrl = TextEditingController();
  final areaImplementacionCtrl = TextEditingController();
  final totalAreaPredioCtrl = TextEditingController();

  String? alianzaExperienciaPecuariaTipoActividadProductivaId;
  String? alianzaExperienciaPecuariaFrecuenciaId;

  final cantidadAnimalesCtrl = TextEditingController();
  final cantidadCriaCtrl = TextEditingController();
  final cantidadLevanteCtrl = TextEditingController();
  final cantidadCebaCtrl = TextEditingController();
  final cantidadLecheCtrl = TextEditingController();
  final alianzaExperienciaPecuariaValorJornalCtrl = TextEditingController();
  final costosInsumosCtrl = TextEditingController();
  final ingresosCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadAlianzaExperienciaPecuaria(widget.alianzaExperienciaPecuaria);
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context).initState();
  }

  void loadAlianzaExperienciaPecuaria(
      AlianzaExperienciaPecuariaEntity? alianzaExperienciaPecuaria) {
    setState(() {
      alianzaExperienciaPecuariaTipoActividadProductivaId =
          alianzaExperienciaPecuaria?.tipoActividadProductivaId;
      alianzaExperienciaPecuariaFrecuenciaId =
          alianzaExperienciaPecuaria?.frecuenciaId;
      cantidadAnimalesCtrl.text =
          alianzaExperienciaPecuaria?.cantidadAnimales ?? '';
      cantidadCriaCtrl.text = alianzaExperienciaPecuaria?.cantidadCria ?? '';
      cantidadLevanteCtrl.text =
          alianzaExperienciaPecuaria?.cantidadLevante ?? '';
      cantidadCebaCtrl.text = alianzaExperienciaPecuaria?.cantidadCeba ?? '';
      cantidadLecheCtrl.text = alianzaExperienciaPecuaria?.cantidadLeche ?? '';
      alianzaExperienciaPecuariaValorJornalCtrl.text =
          alianzaExperienciaPecuaria?.valorJornal ?? '';
      costosInsumosCtrl.text = alianzaExperienciaPecuaria?.costosInsumos ?? '';
      ingresosCtrl.text = alianzaExperienciaPecuaria?.ingresos ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          const Text(
            'Información de Experiencia Pecuaria',
            style: Styles.titleStyle,
          ),
          const SizedBox(height: 20),
          BlocBuilder<TipoActividadProductivaCubit,
              TipoActividadProductivaState>(
            builder: (context, state) {
              if (state is TiposActividadesProductivasLoaded) {
                return DropdownButtonFormField(
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Tipo de Actividad Productiva',
                      labelText: 'Tipo de Actividad Productiva'),
                  value: alianzaExperienciaPecuariaTipoActividadProductivaId,
                  items: state.tiposActividadesProductivas!
                      .map<DropdownMenuItem<String>>(
                          (TipoActividadProductivaEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.tipoActividadProductivaId,
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
                    alianzaExperienciaPecuariaCubit
                        .changeTipoActividadProductiva(value);
                  },
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
            builder: (context, state) {
              if (state is FrecuenciasLoaded) {
                return DropdownButtonFormField(
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Frecuencia', labelText: 'Frecuencia'),
                  value: alianzaExperienciaPecuariaFrecuenciaId,
                  items: state.frecuencias!
                      .map<DropdownMenuItem<String>>((FrecuenciaEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.frecuenciaId,
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
                    alianzaExperienciaPecuariaCubit.changeFrecuencia(value);
                  },
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              controller: cantidadAnimalesCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad de animales',
                  labelText: 'Cantidad de animales'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit
                    .changeCantidadAnimales(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: cantidadCriaCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Cría', labelText: 'Cantidad Cría'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeCantidadCria(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: cantidadLevanteCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Levante', labelText: 'Cantidad Levante'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeCantidadLevante(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: cantidadCebaCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Ceba', labelText: 'Cantidad Ceba'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeCantidadCeba(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: cantidadLecheCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Leche', labelText: 'Cantidad Leche'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeCantidadLeche(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: alianzaExperienciaPecuariaValorJornalCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor Jornal', labelText: 'Valor Jornal'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeValorJornal(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: costosInsumosCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Costo Insumos', labelText: 'Costo Insumos'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeCostosInsumos(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: ingresosCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Ingresos', labelText: 'Ingresos'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaPecuariaCubit.changeIngresos(newValue);
              }),
        ],
      ),
    ));
  }
}
