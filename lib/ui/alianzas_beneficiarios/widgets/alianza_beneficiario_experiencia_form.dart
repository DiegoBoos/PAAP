import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../../domain/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../domain/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class AlianzaBeneficiarioExperienciaForm extends StatefulWidget {
  const AlianzaBeneficiarioExperienciaForm({super.key});

  @override
  State<AlianzaBeneficiarioExperienciaForm> createState() =>
      _AlianzaBeneficiarioExperienciaFormState();
}

class _AlianzaBeneficiarioExperienciaFormState
    extends State<AlianzaBeneficiarioExperienciaForm> {
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

    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);
    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    if (alianzaExperienciaAgricolaCubit.state
        is AlianzaExperienciaAgricolaLoaded) {
      final alianzaExperienciaAgricolaLoaded =
          alianzaExperienciaAgricolaCubit.state.alianzaExperienciaAgricola;

      loadAlianzaExperienciaAgricola(alianzaExperienciaAgricolaLoaded);
    }
    if (alianzaExperienciaPecuariaCubit.state
        is AlianzaExperienciaPecuariaLoaded) {
      final alianzaExperienciaPecuariaLoaded =
          alianzaExperienciaPecuariaCubit.state.alianzaExperienciaPecuaria;

      loadAlianzaExperienciaPecuaria(alianzaExperienciaPecuariaLoaded);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context).initState();
    BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context).initState();
  }

  void loadAlianzaExperienciaAgricola(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaLoaded) {
    alianzaExperienciaAgricolaTipoActividadProductivaId =
        alianzaExperienciaAgricolaLoaded.tipoActividadProductivaId;
    alianzaExperienciaAgricolaFrecuenciaId =
        alianzaExperienciaAgricolaLoaded.frecuenciaId;
    areaCultivoCtrl.text = alianzaExperienciaAgricolaLoaded.areaCultivo;
    cantidadProducidaCtrl.text =
        alianzaExperienciaAgricolaLoaded.cantidadProducida;
    cantidadVendidaCtrl.text = alianzaExperienciaAgricolaLoaded.cantidadVendida;
    cantidadAutoconsumoCtrl.text =
        alianzaExperienciaAgricolaLoaded.cantidadAutoconsumo;
    costoImplementacionCtrl.text =
        alianzaExperienciaAgricolaLoaded.costoImplementacion;
    alianzaExperienciaAgricolaValorJornalCtrl.text =
        alianzaExperienciaAgricolaLoaded.valorJornal;
    totalIngresoNetoCtrl.text =
        alianzaExperienciaAgricolaLoaded.totalIngresoNeto;
    areaPastoCtrl.text = alianzaExperienciaAgricolaLoaded.areaPasto;
    areaSinUsoCtrl.text = alianzaExperienciaAgricolaLoaded.areaSinUso;
    areaReservaConservacionCtrl.text =
        alianzaExperienciaAgricolaLoaded.areaReservaConservacion;
    areaImplementacionCtrl.text =
        alianzaExperienciaAgricolaLoaded.areaImplementacion;
    totalAreaPredioCtrl.text = alianzaExperienciaAgricolaLoaded.totalAreaPredio;
  }

  void loadAlianzaExperienciaPecuaria(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaLoaded) {
    alianzaExperienciaPecuariaTipoActividadProductivaId =
        alianzaExperienciaPecuariaLoaded.tipoActividadProductivaId;
    alianzaExperienciaPecuariaFrecuenciaId =
        alianzaExperienciaPecuariaLoaded.frecuenciaId;
    cantidadAnimalesCtrl.text =
        alianzaExperienciaPecuariaLoaded.cantidadAnimales;
    cantidadCriaCtrl.text = alianzaExperienciaPecuariaLoaded.cantidadCria;
    cantidadLevanteCtrl.text = alianzaExperienciaPecuariaLoaded.cantidadLevante;
    cantidadCebaCtrl.text = alianzaExperienciaPecuariaLoaded.cantidadCeba;
    cantidadLecheCtrl.text = alianzaExperienciaPecuariaLoaded.cantidadLeche;
    alianzaExperienciaPecuariaValorJornalCtrl.text =
        alianzaExperienciaPecuariaLoaded.valorJornal;
    costosInsumosCtrl.text = alianzaExperienciaPecuariaLoaded.costosInsumos;
    ingresosCtrl.text = alianzaExperienciaPecuariaLoaded.ingresos;
  }

  @override
  Widget build(BuildContext context) {
    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);
    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AlianzaExperienciaAgricolaCubit,
            AlianzaExperienciaAgricolaState>(
          listener: (context, state) {
            if (state is AlianzaExperienciaAgricolaLoaded) {
              final alianzaExperienciaAgricolaLoaded =
                  state.alianzaExperienciaAgricolaLoaded;
              loadAlianzaExperienciaAgricola(alianzaExperienciaAgricolaLoaded);
            }
          },
          child: Container(),
        ),
        BlocListener<AlianzaExperienciaPecuariaCubit,
            AlianzaExperienciaPecuariaState>(
          listener: (context, state) {
            if (state is AlianzaExperienciaPecuariaLoaded) {
              final alianzaExperienciaPecuariaLoaded =
                  state.alianzaExperienciaPecuariaLoaded;
              loadAlianzaExperienciaPecuaria(alianzaExperienciaPecuariaLoaded);
            }
          },
          child: Container(),
        )
      ],
      child: BlocBuilder<VAlianzaCubit, VAlianzaState>(
        builder: (context, state) {
          final vAlianza = state.vAlianza!;
          if (vAlianza.tipoProyecto == 'Agrícola') {
            return BlocBuilder<AlianzaExperienciaAgricolaCubit,
                AlianzaExperienciaAgricolaState>(
              builder: (context, state) {
                return Card(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                              value:
                                  alianzaExperienciaAgricolaTipoActividadProductivaId,
                              items: state.tiposActividadesProductivas!
                                  .map<DropdownMenuItem<String>>(
                                      (TipoActividadProductivaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.tipoActividadProductivaId,
                                  child: Text(value.nombre),
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
                                  hintText: 'Frecuencia',
                                  labelText: 'Frecuencia'),
                              value: alianzaExperienciaAgricolaFrecuenciaId,
                              items: state.frecuencias!
                                  .map<DropdownMenuItem<String>>(
                                      (FrecuenciaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.frecuenciaId,
                                  child: Text(value.nombre),
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
                                    .changeFrecuencia(value);
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
                            alianzaExperienciaAgricolaCubit
                                .changeAreaCultivo(newValue);
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
                              hintText: 'Cantidad Vendida',
                              labelText: 'Cantidad Vendida'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaAgricolaCubit
                                .changeCantidadVendida(newValue);
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
                              hintText: 'Valor Jornal',
                              labelText: 'Valor Jornal'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaAgricolaCubit
                                .changeValorJornal(newValue);
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
                              hintText: 'Área de Pastos',
                              labelText: 'Área de Pastos'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaAgricolaCubit
                                .changeAreaPasto(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: areaSinUsoCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Área sin uso',
                              labelText: 'Área sin uso'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaAgricolaCubit
                                .changeAreaSinUso(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: areaReservaConservacionCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Área de Reserva',
                              labelText: 'Área de Reserva'),
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
                            alianzaExperienciaAgricolaCubit
                                .changeTotalAreaPredio(newValue);
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ));
              },
            );
          } else if (vAlianza.tipoProyecto == 'Pecuario') {
            return BlocBuilder<AlianzaExperienciaPecuariaCubit,
                AlianzaExperienciaPecuariaState>(
              builder: (context, state) {
                return Card(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                              value:
                                  alianzaExperienciaPecuariaTipoActividadProductivaId,
                              items: state.tiposActividadesProductivas!
                                  .map<DropdownMenuItem<String>>(
                                      (TipoActividadProductivaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.tipoActividadProductivaId,
                                  child: Text(value.nombre),
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
                                  hintText: 'Frecuencia',
                                  labelText: 'Frecuencia'),
                              value: alianzaExperienciaPecuariaFrecuenciaId,
                              items: state.frecuencias!
                                  .map<DropdownMenuItem<String>>(
                                      (FrecuenciaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.frecuenciaId,
                                  child: Text(value.nombre),
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
                                    .changeFrecuencia(value);
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
                              hintText: 'Cantidad Cría',
                              labelText: 'Cantidad Cría'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeCantidadCria(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: cantidadLevanteCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Cantidad Levante',
                              labelText: 'Cantidad Levante'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeCantidadLevante(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: cantidadCebaCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Cantidad Ceba',
                              labelText: 'Cantidad Ceba'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeCantidadCeba(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: cantidadLecheCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Cantidad Leche',
                              labelText: 'Cantidad Leche'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeCantidadLeche(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: alianzaExperienciaPecuariaValorJornalCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Valor Jornal',
                              labelText: 'Valor Jornal'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeValorJornal(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: costosInsumosCtrl,
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Costo Insumos',
                              labelText: 'Costo Insumos'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Requerido';
                            }
                            return null;
                          },
                          onSaved: (String? newValue) {
                            alianzaExperienciaPecuariaCubit
                                .changeCostosInsumos(newValue);
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
                            alianzaExperienciaPecuariaCubit
                                .changeIngresos(newValue);
                          }),
                    ],
                  ),
                ));
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
