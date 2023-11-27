import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../../ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ExperienciaAgricolaForm extends StatefulWidget {
  const ExperienciaAgricolaForm({super.key});

  @override
  State<ExperienciaAgricolaForm> createState() =>
      _ExperienciaAgricolaFormState();
}

class _ExperienciaAgricolaFormState extends State<ExperienciaAgricolaForm> {
  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<ExperienciaAgricolaCubit>(context).initState();
    BlocProvider.of<ExperienciaPecuariaCubit>(context).initState();
  }

  String? tipoActividadProductivaId;
  String? frecuenciaId;
  final areaCultivoCtrl = TextEditingController();
  final cantidadProducidaCtrl = TextEditingController();
  final cantidadVendidaCtrl = TextEditingController();
  final cantidadAutoconsumoCtrl = TextEditingController();
  final costoImplementacionCtrl = TextEditingController();
  final experienciaAgricolaValorJornalCtrl = TextEditingController();
  final totalIngresoNetoCtrl = TextEditingController();
  final areaPastoCtrl = TextEditingController();
  final areaSinUsoCtrl = TextEditingController();
  final areaReservaConservacionCtrl = TextEditingController();
  final areaImplementacionCtrl = TextEditingController();
  final totalAreaPredioCtrl = TextEditingController();

  void loadExperienciaAgricola(ExperienciaAgricolaEntity experienciaAgricola) {
    setState(() {
      tipoActividadProductivaId = experienciaAgricola.tipoActividadProductivaId;
      frecuenciaId = experienciaAgricola.frecuenciaId;
      areaCultivoCtrl.text = experienciaAgricola.areaCultivo ?? '';
      cantidadProducidaCtrl.text = experienciaAgricola.cantidadProducida ?? '';
      cantidadVendidaCtrl.text = experienciaAgricola.cantidadVendida ?? '';
      cantidadAutoconsumoCtrl.text =
          experienciaAgricola.cantidadAutoconsumo ?? '';
      costoImplementacionCtrl.text =
          experienciaAgricola.costoImplementacion ?? '';
      experienciaAgricolaValorJornalCtrl.text =
          experienciaAgricola.valorJornal ?? '';
      totalIngresoNetoCtrl.text = experienciaAgricola.totalIngresoNeto ?? '';
      areaPastoCtrl.text = experienciaAgricola.areaPasto ?? '';
      areaSinUsoCtrl.text = experienciaAgricola.areaSinUso ?? '';
      areaReservaConservacionCtrl.text =
          experienciaAgricola.areaReservaConservacion ?? '';
      areaImplementacionCtrl.text =
          experienciaAgricola.areaImplementacion ?? '';
      totalAreaPredioCtrl.text = experienciaAgricola.totalAreaPredio ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          const Text(
            'Información de Experiencia Agrícola',
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
                    experienciaAgricolaCubit
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
                    experienciaAgricolaCubit.changeFrecuencia(value);
                  },
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: areaCultivoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Área del Cultivo Hectárea',
                  labelText: 'Área del Cultivo Hectárea'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeAreaCultivo(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: cantidadProducidaCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Producida',
                  labelText: 'Cantidad Producida'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeCantidadProducida(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: cantidadVendidaCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Vendida', labelText: 'Cantidad Vendida'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeCantidadVendida(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: cantidadAutoconsumoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Cantidad Autoconsumo',
                  labelText: 'Cantidad Autoconsumo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeCantidadAutoconsumo(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: costoImplementacionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Costo de implementación',
                  labelText: 'Costo de implementación'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeCostoImplementacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: experienciaAgricolaValorJornalCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor Jornal', labelText: 'Valor Jornal'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeValorJornal(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: totalIngresoNetoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Ingreso Total Neto',
                  labelText: 'Ingreso Total Neto'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeTotalIngresoNeto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: areaPastoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Área de Pastos', labelText: 'Área de Pastos'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeAreaPasto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: areaSinUsoCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Área sin uso', labelText: 'Área sin uso'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeAreaSinUso(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: areaReservaConservacionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Área de Reserva', labelText: 'Área de Reserva'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit
                    .changeAreaReservaConservacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: areaImplementacionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Área Implementación',
                  labelText: 'Área Implementación'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeAreaImplementacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: totalAreaPredioCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Total Área Predio',
                  labelText: 'Total Área Predio'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                experienciaAgricolaCubit.changeTotalAreaPredio(newValue);
              }),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
