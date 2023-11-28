import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class ExperienciaAgricolaForm extends StatefulWidget {
  const ExperienciaAgricolaForm(this.alianzaExperienciaAgricola, {super.key});
  final AlianzaExperienciaAgricolaEntity? alianzaExperienciaAgricola;

  @override
  State<ExperienciaAgricolaForm> createState() =>
      _ExperienciaAgricolaFormState();
}

class _ExperienciaAgricolaFormState extends State<ExperienciaAgricolaForm> {
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

    loadAlianzaExperienciaAgricola(widget.alianzaExperienciaAgricola);
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context).initState();
  }

  void loadAlianzaExperienciaAgricola(
      AlianzaExperienciaAgricolaEntity? alianzaExperienciaAgricola) {
    setState(() {
      alianzaExperienciaAgricolaTipoActividadProductivaId =
          alianzaExperienciaAgricola?.tipoActividadProductivaId;
      alianzaExperienciaAgricolaFrecuenciaId =
          alianzaExperienciaAgricola?.frecuenciaId;
      areaCultivoCtrl.text = alianzaExperienciaAgricola?.areaCultivo ?? '';
      cantidadProducidaCtrl.text =
          alianzaExperienciaAgricola?.cantidadProducida ?? '';
      cantidadVendidaCtrl.text =
          alianzaExperienciaAgricola?.cantidadVendida ?? '';
      cantidadAutoconsumoCtrl.text =
          alianzaExperienciaAgricola?.cantidadAutoconsumo ?? '';
      costoImplementacionCtrl.text =
          alianzaExperienciaAgricola?.costoImplementacion ?? '';
      alianzaExperienciaAgricolaValorJornalCtrl.text =
          alianzaExperienciaAgricola?.valorJornal ?? '';
      totalIngresoNetoCtrl.text =
          alianzaExperienciaAgricola?.totalIngresoNeto ?? '';
      areaPastoCtrl.text = alianzaExperienciaAgricola?.areaPasto ?? '';
      areaSinUsoCtrl.text = alianzaExperienciaAgricola?.areaSinUso ?? '';
      areaReservaConservacionCtrl.text =
          alianzaExperienciaAgricola?.areaReservaConservacion ?? '';
      areaImplementacionCtrl.text =
          alianzaExperienciaAgricola?.areaImplementacion ?? '';
      totalAreaPredioCtrl.text =
          alianzaExperienciaAgricola?.totalAreaPredio ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);

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
                  value: alianzaExperienciaAgricolaTipoActividadProductivaId,
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
                    alianzaExperienciaAgricolaCubit
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
                  value: alianzaExperienciaAgricolaFrecuenciaId,
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
                    alianzaExperienciaAgricolaCubit.changeFrecuencia(value);
                  },
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit.changeAreaCultivo(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeCantidadProducida(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit.changeCantidadVendida(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeCantidadAutoconsumo(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeCostoImplementacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
              controller: alianzaExperienciaAgricolaValorJornalCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor Jornal', labelText: 'Valor Jornal'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo Requerido';
                }
                return null;
              },
              onSaved: (String? newValue) {
                alianzaExperienciaAgricolaCubit.changeValorJornal(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeTotalIngresoNeto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit.changeAreaPasto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit.changeAreaSinUso(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeAreaReservaConservacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit
                    .changeAreaImplementacion(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
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
                alianzaExperienciaAgricolaCubit.changeTotalAreaPredio(newValue);
              }),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
