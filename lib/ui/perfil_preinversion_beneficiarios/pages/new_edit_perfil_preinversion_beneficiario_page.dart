import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import '../../../ui/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/experiencia_agricola_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/experiencia_pecuaria_form.dart';
import '../widgets/perfil_beneficiario_form.dart';
import '../widgets/perfil_preinversion_beneficiario_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditPerfilPreInversionBeneficiarioPage extends StatelessWidget {
  NewEditPerfilPreInversionBeneficiarioPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final perfilPreInversionBeneficiariosBloc =
        BlocProvider.of<PerfilPreInversionBeneficiariosBloc>(context);
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final tipoProyecto =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.tipoProyecto;

    return BlocConsumer<PerfilPreInversionBeneficiarioCubit,
        PerfilPreInversionBeneficiarioState>(listener: (context, state) {
      if (state is PerfilPreInversionBeneficiarioError) {
        CustomSnackBar.showSnackBar(
            context, 'Error al cargar/guardar datos', Colors.red);
      }
      if (state is PerfilPreInversionBeneficiarioSaved) {
        CustomSnackBar.showSnackBar(
            context, 'Datos guardados satisfactoriamente', Colors.green);

        final perfilPreInversionId =
            state.perfilPreInversionBeneficiario.perfilPreInversionId!;
        perfilPreInversionBeneficiariosBloc
            .add(GetPerfilPreInversionBeneficiarios(perfilPreInversionId));
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      final perfilPreInversionBeneficiario =
          state.perfilPreInversionBeneficiario;

      final beneficiarioId = perfilPreInversionBeneficiario.beneficiarioId;

      final estadoCivilId = perfilPreInversionBeneficiario.estadoCivilId;

      return Scaffold(
          drawer: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
              return PerfilPreInversionDrawer(
                menuHijo: menuHijo,
              );
            },
          ),
          appBar: AppBar(
              title: Text(beneficiarioId == null ? 'Crear' : 'Editar'),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: NetworkIcon(),
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    BeneficiarioForm(
                        perfilPreInversionBeneficiario:
                            perfilPreInversionBeneficiario),
                    PerfilBeneficiarioForm(
                      perfilPreInversionBeneficiario:
                          perfilPreInversionBeneficiario,
                    ),
                    PerfilPreInversionBeneficiarioForm(
                        perfilPreInversionBeneficiario:
                            perfilPreInversionBeneficiario),
                    if (estadoCivilId == '2' || estadoCivilId == '5')
                      ConyugeForm(
                        perfilPreInversionBeneficiario:
                            perfilPreInversionBeneficiario,
                      ),
                    BeneficiarioExperiencia(
                        tipoProyecto: tipoProyecto,
                        beneficiarioId: beneficiarioId),
                    const SizedBox(height: 10),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        formKey.currentState!.save();

                        saveBeneficiario(context);
                        savePerfilPreInversionBeneficiario(context);
                        saveExperiencia(context);
                      },
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ));
    });
  }

  void saveBeneficiario(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    beneficiarioCubit.changeActivo('true');

    beneficiarioCubit.saveBeneficiarioDB();
  }

  void savePerfilPreInversionBeneficiario(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    final perfilPreInversionBeneficiario = perfilPreInversionBeneficiarioCubit
        .state.perfilPreInversionBeneficiario;

    perfilPreInversionBeneficiarioCubit
        .changePerfilPreInversionId(perfilPreInversionId);

    perfilPreInversionBeneficiarioCubit.changeConocePerfil('true');

    if (perfilPreInversionBeneficiario.fueBeneficiado == null) {
      perfilPreInversionBeneficiarioCubit.changeFueBeneficiado('false');
    }
    if (perfilPreInversionBeneficiario.activo == null) {
      perfilPreInversionBeneficiarioCubit.changeActivo('false');
    }
    if (perfilPreInversionBeneficiario.cotizanteBeps == null) {
      perfilPreInversionBeneficiarioCubit.changeCotizanteBeps('false');
    }
    if (perfilPreInversionBeneficiario.accesoExplotacionTierra == null) {
      perfilPreInversionBeneficiarioCubit
          .changeAccesoExplotacionTierra('false');
    }

    perfilPreInversionBeneficiarioCubit.savePerfilPreInversionBeneficiarioDB();
  }

  void saveExperiencia(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);
    final tipoProyecto =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.tipoProyecto;

    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId!;

    if (tipoProyecto == 'Agrícola') {
      experienciaAgricolaCubit.changeBeneficiarioId(beneficiarioId);

      experienciaAgricolaCubit.saveExperienciaAgricolaDB();
    } else if (tipoProyecto == 'Pecuario') {
      experienciaPecuariaCubit.changeBeneficiarioId(beneficiarioId);

      experienciaPecuariaCubit.saveExperienciaPecuariaDB();
    }
  }
}

class BeneficiarioExperiencia extends StatefulWidget {
  const BeneficiarioExperiencia(
      {super.key, required this.tipoProyecto, required this.beneficiarioId});
  final String? tipoProyecto;
  final String? beneficiarioId;

  @override
  State<BeneficiarioExperiencia> createState() =>
      _BeneficiarioExperienciaState();
}

class _BeneficiarioExperienciaState extends State<BeneficiarioExperiencia> {
  @override
  void initState() {
    super.initState();
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    if (widget.beneficiarioId != null) {
      if (widget.tipoProyecto == 'Agrícola') {
        experienciaAgricolaCubit.loadExperienciaAgricola(
            '1', widget.beneficiarioId!);
      } else if (widget.tipoProyecto == 'Pecuario') {
        experienciaPecuariaCubit.loadExperienciaPecuaria(
            '1', widget.beneficiarioId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
      listener: (context, state) {
        if (state is BeneficiarioLoaded) {
          final beneficiarioId = state.beneficiarioLoaded.beneficiarioId!;

          if (widget.tipoProyecto == 'Agrícola') {
            experienciaAgricolaCubit.loadExperienciaAgricola(
                '1', beneficiarioId);
          } else if (widget.tipoProyecto == 'Pecuario') {
            experienciaPecuariaCubit.loadExperienciaPecuaria(
                '1', beneficiarioId);
          }
        }
      },
      child: Column(
        children: [
          BlocBuilder<ExperienciaAgricolaCubit, ExperienciaAgricolaState>(
            builder: (context, state) {
              if (state is ExperienciaAgricolaLoaded) {
                final experienciaAgricola = state.experienciaAgricola;
                return ExperienciaAgricolaForm(experienciaAgricola);
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<ExperienciaPecuariaCubit, ExperienciaPecuariaState>(
            builder: (context, state) {
              if (state is ExperienciaPecuariaLoaded) {
                final experienciaPecuaria = state.experienciaPecuaria;
                return ExperienciaPecuariaForm(experienciaPecuaria);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
