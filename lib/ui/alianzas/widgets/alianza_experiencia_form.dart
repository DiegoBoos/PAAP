import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../ui/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';
import 'package:paap/domain/entities/experiencia_agricola_entity.dart';
import 'package:paap/domain/entities/experiencia_pecuaria_entity.dart';

class AlianzaExperienciaForm extends StatefulWidget {
  const AlianzaExperienciaForm({super.key});

  @override
  State<AlianzaExperienciaForm> createState() => _AlianzaExperienciaFormState();
}

class _AlianzaExperienciaFormState extends State<AlianzaExperienciaForm> {
  String? experienciaAgricolaTipoActividadProductivaId;
  String? experienciaAgricolaFrecuenciaId;

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

  String? experienciaPecuariaTipoActividadProductivaId;
  String? experienciaPecuariaFrecuenciaId;

  final cantidadAnimalesCtrl = TextEditingController();
  final cantidadCriaCtrl = TextEditingController();
  final cantidadLevanteCtrl = TextEditingController();
  final cantidadCebaCtrl = TextEditingController();
  final cantidadLecheCtrl = TextEditingController();
  final experienciaPecuariaValorJornalCtrl = TextEditingController();
  final costosInsumosCtrl = TextEditingController();
  final ingresosCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    loadExperienciaAgricola(experienciaAgricolaCubit.state.experienciaAgricola);
    loadExperienciaPecuaria(experienciaPecuariaCubit.state.experienciaPecuaria);
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<ExperienciaAgricolaCubit>(context).initState();
    BlocProvider.of<ExperienciaPecuariaCubit>(context).initState();
  }

  void loadExperienciaAgricola(ExperienciaAgricolaEntity? experienciaAgricola) {
    setState(() {
      experienciaAgricolaTipoActividadProductivaId =
          experienciaAgricola?.tipoActividadProductivaId;
      experienciaAgricolaFrecuenciaId = experienciaAgricola?.frecuenciaId;
      areaCultivoCtrl.text = experienciaAgricola?.areaCultivo ?? '';
      cantidadProducidaCtrl.text = experienciaAgricola?.cantidadProducida ?? '';
      cantidadVendidaCtrl.text = experienciaAgricola?.cantidadVendida ?? '';
      cantidadAutoconsumoCtrl.text =
          experienciaAgricola?.cantidadAutoconsumo ?? '';
      costoImplementacionCtrl.text =
          experienciaAgricola?.costoImplementacion ?? '';
      experienciaAgricolaValorJornalCtrl.text =
          experienciaAgricola?.valorJornal ?? '';
      totalIngresoNetoCtrl.text = experienciaAgricola?.totalIngresoNeto ?? '';
      areaPastoCtrl.text = experienciaAgricola?.areaPasto ?? '';
      areaSinUsoCtrl.text = experienciaAgricola?.areaSinUso ?? '';
      areaReservaConservacionCtrl.text =
          experienciaAgricola?.areaReservaConservacion ?? '';
      areaImplementacionCtrl.text =
          experienciaAgricola?.areaImplementacion ?? '';
      totalAreaPredioCtrl.text = experienciaAgricola?.totalAreaPredio ?? '';
    });
  }

  void loadExperienciaPecuaria(ExperienciaPecuariaEntity? experienciaPecuaria) {
    setState(() {
      experienciaPecuariaTipoActividadProductivaId =
          experienciaPecuaria?.tipoActividadProductivaId;
      experienciaPecuariaFrecuenciaId = experienciaPecuaria?.frecuenciaId;
      cantidadAnimalesCtrl.text = experienciaPecuaria?.cantidadAnimales ?? '';
      cantidadCriaCtrl.text = experienciaPecuaria?.cantidadCria ?? '';
      cantidadLevanteCtrl.text = experienciaPecuaria?.cantidadLevante ?? '';
      cantidadCebaCtrl.text = experienciaPecuaria?.cantidadCeba ?? '';
      cantidadLecheCtrl.text = experienciaPecuaria?.cantidadLeche ?? '';
      experienciaPecuariaValorJornalCtrl.text =
          experienciaPecuaria?.valorJornal ?? '';
      costosInsumosCtrl.text = experienciaPecuaria?.costosInsumos ?? '';
      ingresosCtrl.text = experienciaPecuaria?.ingresos ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ExperienciaAgricolaCubit, ExperienciaAgricolaState>(
          listener: (context, state) {
            if (state is ExperienciaAgricolaLoaded) {
              final experienciaAgricolaLoaded = state.experienciaAgricolaLoaded;
              loadExperienciaAgricola(experienciaAgricolaLoaded);
            }
          },
          child: Container(),
        ),
        BlocListener<ExperienciaPecuariaCubit, ExperienciaPecuariaState>(
          listener: (context, state) {
            if (state is ExperienciaPecuariaLoaded) {
              final experienciaPecuariaLoaded = state.experienciaPecuariaLoaded;
              loadExperienciaPecuaria(experienciaPecuariaLoaded);
            }
          },
          child: Container(),
        )
      ],
      child: BlocBuilder<VPerfilPreInversionCubit, VPerfilPreInversionState>(
        builder: (context, state) {
          final vPerfilPreinversion = state.vPerfilPreInversion!;
          if (vPerfilPreinversion.tipoProyecto == 'Agrícola') {
            return BlocBuilder<ExperienciaAgricolaCubit,
                ExperienciaAgricolaState>(
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
                              value: experienciaAgricolaTipoActividadProductivaId !=
                                      ''
                                  ? experienciaAgricolaTipoActividadProductivaId
                                  : null,
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
                                  hintText: 'Frecuencia',
                                  labelText: 'Frecuencia'),
                              value: experienciaAgricolaFrecuenciaId != ''
                                  ? experienciaAgricolaFrecuenciaId
                                  : null,
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
                                experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
                                .changeCostoImplementacion(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: experienciaAgricolaValorJornalCtrl,
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit.changeAreaPasto(newValue);
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
                            experienciaAgricolaCubit.changeAreaSinUso(newValue);
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
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
                            experienciaAgricolaCubit
                                .changeTotalAreaPredio(newValue);
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ));
              },
            );
          } else if (vPerfilPreinversion.tipoProyecto == 'Pecuario') {
            return BlocBuilder<ExperienciaPecuariaCubit,
                ExperienciaPecuariaState>(
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
                              value: experienciaPecuariaTipoActividadProductivaId !=
                                      ''
                                  ? experienciaPecuariaTipoActividadProductivaId
                                  : null,
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
                                  hintText: 'Frecuencia',
                                  labelText: 'Frecuencia'),
                              value: experienciaPecuariaFrecuenciaId != ''
                                  ? experienciaPecuariaFrecuenciaId
                                  : null,
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
                                experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
                                .changeCantidadLeche(newValue);
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: experienciaPecuariaValorJornalCtrl,
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit
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
                            experienciaPecuariaCubit.changeIngresos(newValue);
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
