import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../../ui/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../../ui/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/v_alianza/v_alianza_cubit.dart';
import '../../alianzas/widgets/alianza_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/alianza_beneficiario_form.dart';
import '../widgets/alianza_perfil_beneficiario_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/conyuge_form.dart';
import '../widgets/experiencia_agricola_form.dart';
import '../widgets/experiencia_pecuaria_form.dart';

class NewEditAlianzaBeneficiarioPage extends StatelessWidget {
  const NewEditAlianzaBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);
    final tipoProyecto = vAlianzaCubit.state.vAlianza!.tipoProyecto;

    return BlocConsumer<AlianzaBeneficiarioCubit, AlianzaBeneficiarioState>(
      listener: (context, state) {
        if (state is AlianzaBeneficiarioError) {
          CustomSnackBar.showSnackBar(
              context, 'Error al cargar/guardar datos', Colors.red);
        }
        if (state is AlianzaBeneficiarioSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);
        }
      },
      builder: (context, state) {
        final alianzaBeneficiario = state.alianzaBeneficiario;

        final beneficiarioId = alianzaBeneficiario.beneficiarioId;

        final estadoCivilId = alianzaBeneficiario.estadoCivilId;

        return Scaffold(
            drawer: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                final menuHijo = menuCubit.alianzaMenuSorted(state.menus!);
                return AlianzaDrawer(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      BeneficiarioForm(
                          alianzaBeneficiario: alianzaBeneficiario),
                      AlianzaPerfilBeneficiarioForm(
                          alianzaBeneficiario: alianzaBeneficiario),
                      AlianzaBeneficiarioForm(
                          alianzaBeneficiario: alianzaBeneficiario),
                      if (estadoCivilId == '2' || estadoCivilId == '5')
                        ConyugeForm(alianzaBeneficiario: alianzaBeneficiario),
                      AlianzaBeneficiarioExperiencia(
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
                          saveAlianzaBeneficiario(context);
                          saveExperiencia(context);
                        },
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  void saveBeneficiario(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    beneficiarioCubit.changeActivo('true');

    beneficiarioCubit.saveBeneficiarioDB();
  }

  void saveAlianzaBeneficiario(BuildContext context) {
    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);

    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);

    final alianzaId = vAlianzaCubit.state.vAlianza!.alianzaId!;

    alianzaBeneficiarioCubit.changeAlianzaId(alianzaId);
    alianzaBeneficiarioCubit.changeConocePerfil('true');

    final alianzaBeneficiario =
        alianzaBeneficiarioCubit.state.alianzaBeneficiario;

    if (alianzaBeneficiario.fueBeneficiado == null) {
      alianzaBeneficiarioCubit.changeFueBeneficiado('false');
    }
    if (alianzaBeneficiario.activo == null) {
      alianzaBeneficiarioCubit.changeActivo('false');
    }
    if (alianzaBeneficiario.cotizanteBeps == null) {
      alianzaBeneficiarioCubit.changeCotizanteBeps('false');
    }
    if (alianzaBeneficiario.accesoExplotacionTierra == null) {
      alianzaBeneficiarioCubit.changeAccesoExplotacionTierra('false');
    }

    alianzaBeneficiarioCubit.saveAlianzaBeneficiarioDB();
  }

  void saveExperiencia(BuildContext context) {
    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);
    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);
    final tipoProyecto = vAlianzaCubit.state.vAlianza!.tipoProyecto;

    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId!;

    if (tipoProyecto == 'Agrícola') {
      alianzaExperienciaAgricolaCubit.changeBeneficiarioId(beneficiarioId);

      final alianzaExperienciaAgricola =
          alianzaExperienciaAgricolaCubit.state.alianzaExperienciaAgricola;

      alianzaExperienciaAgricolaCubit
          .saveAlianzaExperienciaAgricolaDB(alianzaExperienciaAgricola);
    } else if (tipoProyecto == 'Pecuario') {
      alianzaExperienciaPecuariaCubit.changeBeneficiarioId(beneficiarioId);

      final alianzaExperienciaPecuaria =
          alianzaExperienciaPecuariaCubit.state.alianzaExperienciaPecuaria;

      alianzaExperienciaPecuariaCubit
          .saveAlianzaExperienciaPecuariaDB(alianzaExperienciaPecuaria);
    }
  }
}

class AlianzaBeneficiarioExperiencia extends StatefulWidget {
  const AlianzaBeneficiarioExperiencia(
      {super.key, required this.tipoProyecto, required this.beneficiarioId});
  final String? tipoProyecto;
  final String? beneficiarioId;

  @override
  State<AlianzaBeneficiarioExperiencia> createState() =>
      _AlianzaBeneficiarioExperienciaState();
}

class _AlianzaBeneficiarioExperienciaState
    extends State<AlianzaBeneficiarioExperiencia> {
  @override
  void initState() {
    super.initState();

    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);

    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    if (widget.beneficiarioId != null) {
      if (widget.tipoProyecto == 'Agrícola') {
        alianzaExperienciaAgricolaCubit.loadAlianzaExperienciaAgricola(
            '1', widget.beneficiarioId!);
      } else if (widget.tipoProyecto == 'Pecuario') {
        alianzaExperienciaPecuariaCubit.loadAlianzaExperienciaPecuaria(
            '1', widget.beneficiarioId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);

    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
      listener: (context, state) {
        if (state is BeneficiarioLoaded) {
          final beneficiarioId = state.beneficiarioLoaded.beneficiarioId!;

          if (widget.tipoProyecto == 'Agrícola') {
            alianzaExperienciaAgricolaCubit.loadAlianzaExperienciaAgricola(
                '1', beneficiarioId);
          } else if (widget.tipoProyecto == 'Pecuario') {
            alianzaExperienciaPecuariaCubit.loadAlianzaExperienciaPecuaria(
                '1', beneficiarioId);
          }
        }
      },
      child: Column(
        children: [
          BlocBuilder<AlianzaExperienciaAgricolaCubit,
              AlianzaExperienciaAgricolaState>(
            builder: (context, state) {
              if (state is AlianzaExperienciaAgricolaLoaded) {
                final alianzaExperienciaAgricola =
                    state.alianzaExperienciaAgricolaLoaded;
                return ExperienciaAgricolaForm(alianzaExperienciaAgricola);
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<AlianzaExperienciaPecuariaCubit,
              AlianzaExperienciaPecuariaState>(
            builder: (context, state) {
              if (state is AlianzaExperienciaPecuariaLoaded) {
                final alianzaExperienciaPecuaria =
                    state.alianzaExperienciaPecuariaLoaded;
                return ExperienciaPecuariaForm(alianzaExperienciaPecuaria);
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
