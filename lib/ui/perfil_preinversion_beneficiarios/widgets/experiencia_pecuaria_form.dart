import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../../ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ExperienciaPecuariaForm extends StatefulWidget {
  const ExperienciaPecuariaForm({super.key});

  @override
  State<ExperienciaPecuariaForm> createState() =>
      _ExperienciaPecuariaFormState();
}

class _ExperienciaPecuariaFormState extends State<ExperienciaPecuariaForm> {
  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<ExperienciaAgricolaCubit>(context).initState();
    BlocProvider.of<ExperienciaPecuariaCubit>(context).initState();
  }

  String? tipoActividadProductivaId;
  String? frecuenciaId;
  final cantidadAnimalesCtrl = TextEditingController();
  final cantidadCriaCtrl = TextEditingController();
  final cantidadLevanteCtrl = TextEditingController();
  final cantidadCebaCtrl = TextEditingController();
  final cantidadLecheCtrl = TextEditingController();
  final experienciaPecuariaValorJornalCtrl = TextEditingController();
  final costosInsumosCtrl = TextEditingController();
  final ingresosCtrl = TextEditingController();

  void loadExperienciaPecuaria(ExperienciaPecuariaEntity experienciaPecuaria) {
    setState(() {
      tipoActividadProductivaId = experienciaPecuaria.tipoActividadProductivaId;
      frecuenciaId = experienciaPecuaria.frecuenciaId;
      cantidadAnimalesCtrl.text = experienciaPecuaria.cantidadAnimales ?? '';
      cantidadCriaCtrl.text = experienciaPecuaria.cantidadCria ?? '';
      cantidadLevanteCtrl.text = experienciaPecuaria.cantidadLevante ?? '';
      cantidadCebaCtrl.text = experienciaPecuaria.cantidadCeba ?? '';
      cantidadLecheCtrl.text = experienciaPecuaria.cantidadLeche ?? '';
      experienciaPecuariaValorJornalCtrl.text =
          experienciaPecuaria.valorJornal ?? '';
      costosInsumosCtrl.text = experienciaPecuaria.costosInsumos ?? '';
      ingresosCtrl.text = experienciaPecuaria.ingresos ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);
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
                  value: tipoActividadProductivaId,
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
                    experienciaPecuariaCubit
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
                  value: frecuenciaId,
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
                    experienciaPecuariaCubit.changeFrecuencia(value);
                  },
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCantidadAnimales(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCantidadCria(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCantidadLevante(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCantidadCeba(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCantidadLeche(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: experienciaPecuariaValorJornalCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor Jornal', labelText: 'Valor Jornal'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaPecuariaCubit.changeValorJornal(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeCostosInsumos(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
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
                experienciaPecuariaCubit.changeIngresos(newValue);
              }),
        ],
      ),
    ));
  }
}
