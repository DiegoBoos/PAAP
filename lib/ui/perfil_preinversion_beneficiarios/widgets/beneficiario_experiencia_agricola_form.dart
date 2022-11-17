import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';

import '../../../domain/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/frecuencia/frecuencia_cubit.dart';
import '../../../domain/cubits/tipo_actividad_productiva/tipo_actividad_productiva_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class BeneficiarioExperienciaAgricolaForm extends StatefulWidget {
  const BeneficiarioExperienciaAgricolaForm({super.key});

  @override
  State<BeneficiarioExperienciaAgricolaForm> createState() =>
      _BeneficiarioExperienciaAgricolaFormState();
}

class _BeneficiarioExperienciaAgricolaFormState
    extends State<BeneficiarioExperienciaAgricolaForm> {
  @override
  Widget build(BuildContext context) {
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    return BlocBuilder<VPerfilPreInversionCubit, VPerfilPreInversionState>(
      builder: (context, state) {
        final vPerfilPreinversion = state.vPerfilPreInversion!;
        if (vPerfilPreinversion.tipoProyecto == 'Agrícola') {
          return BlocBuilder<ExperienciaAgricolaCubit,
              ExperienciaAgricolaState>(
            builder: (context, state) {
              final experienciaAgricola = state.experienciaAgricola;

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
                              items: state.tiposActividadesProductivas!
                                  .map<DropdownMenuItem<String>>(
                                      (TipoActividadProductivaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.tipoActividadProductivaId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                experienciaAgricolaCubit
                                    .changeTipoActividadProductiva(value);
                              },
                              hint: const Text('Tipo de Actividad Productiva'));
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                      builder: (context, state) {
                        if (state is FrecuenciasLoaded) {
                          return DropdownButtonFormField(
                              items: state.frecuencias!
                                  .map<DropdownMenuItem<String>>(
                                      (FrecuenciaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.frecuenciaId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                experienciaAgricolaCubit
                                    .changeFrecuencia(value);
                              },
                              hint: const Text('Frecuencia'));
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.areaCultivo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Área del Cultivo Hectárea',
                            labelText: 'Área del Cultivo Hectárea'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit.changeAreaCultivo(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.cantidadProducida,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Producida',
                            labelText: 'Cantidad Producida'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeCantidadProducida(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.cantidadVendida,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Vendida',
                            labelText: 'Cantidad Vendida'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeCantidadVendida(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.cantidadAutoconsumo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Autoconsumo',
                            labelText: 'Cantidad Autoconsumo'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeCantidadAutoconsumo(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.costoImplementacion,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Costo de implementación',
                            labelText: 'Costo de implementación'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeCostoImplementacion(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.valorJornal,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Valor Jornal',
                            labelText: 'Valor Jornal'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit.changeValorJornal(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.totalIngresoNeto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Ingreso Total Neto',
                            labelText: 'Ingreso Total Neto'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeTotalIngresoNeto(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.areaPasto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Área de Pastos',
                            labelText: 'Área de Pastos'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit.changeAreaPasto(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.areaSinUso,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Área sin uso',
                            labelText: 'Área sin uso'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit.changeAreaSinUso(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue:
                            experienciaAgricola?.areaReservaConservacion,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Área de Reserva',
                            labelText: 'Área de Reserva'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeAreaReservaConservacion(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.areaImplementacion,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Área Implementación',
                            labelText: 'Área Implementación'),
                        onSaved: (String? newValue) {
                          experienciaAgricolaCubit
                              .changeAreaImplementacion(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaAgricola?.totalAreaPredio,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Total Área Predio',
                            labelText: 'Total Área Predio'),
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
              final experienciaPecuaria = state.experienciaPecuaria;

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
                              items: state.tiposActividadesProductivas!
                                  .map<DropdownMenuItem<String>>(
                                      (TipoActividadProductivaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.tipoActividadProductivaId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                experienciaPecuariaCubit
                                    .changeTipoActividadProductiva(value);
                              },
                              hint: const Text('Tipo de Actividad Productiva'));
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<FrecuenciaCubit, FrecuenciaState>(
                      builder: (context, state) {
                        if (state is FrecuenciasLoaded) {
                          return DropdownButtonFormField(
                              items: state.frecuencias!
                                  .map<DropdownMenuItem<String>>(
                                      (FrecuenciaEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.frecuenciaId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                experienciaPecuariaCubit
                                    .changeFrecuencia(value);
                              },
                              hint: const Text('Frecuencia'));
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.cantidadAnimales,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad de animales',
                            labelText: 'Cantidad de animales'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit
                              .changeCantidadAnimales(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.cantidadCria,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Cría',
                            labelText: 'Cantidad Cría'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit.changeCantidadCria(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.cantidadLevante,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Levante',
                            labelText: 'Cantidad Levante'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit
                              .changeCantidadLevante(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.cantidadCeba,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Ceba',
                            labelText: 'Cantidad Ceba'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit.changeCantidadCeba(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.cantidadLeche,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Cantidad Leche',
                            labelText: 'Cantidad Leche'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit
                              .changeCantidadLeche(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.valorJornal,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Valor Jornal',
                            labelText: 'Valor Jornal'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit.changeValorJornal(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.costosInsumos,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Costo Insumos',
                            labelText: 'Costo Insumos'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit
                              .changeCostosInsumos(newValue);
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: experienciaPecuaria?.ingresos,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Ingresos', labelText: 'Ingresos'),
                        onSaved: (String? newValue) {
                          experienciaPecuariaCubit.changeIngresos(newValue);
                        }),
                  ],
                ),
              ));
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
