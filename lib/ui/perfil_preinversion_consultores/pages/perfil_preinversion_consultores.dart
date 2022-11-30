import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import '../../../domain/cubits/consultor/consultor_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_consultores_rows.dart';

class PerfilPreInversionConsultoresPage extends StatefulWidget {
  const PerfilPreInversionConsultoresPage({super.key});

  @override
  State<PerfilPreInversionConsultoresPage> createState() =>
      _PerfilPreInversionConsultoresPageState();
}

class _PerfilPreInversionConsultoresPageState
    extends State<PerfilPreInversionConsultoresPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionConsultoresBloc =
        BlocProvider.of<PerfilPreInversionConsultoresBloc>(context);

    perfilPreInversionConsultoresBloc.add(GetPerfilPreInversionConsultores(
        vPerfilPreInversionCubit
            .state.vPerfilPreInversion!.perfilPreInversionId));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
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
            title: const Text(' Consultor'),
            centerTitle: true,
            leading: null,
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: ListView(children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('Asignación de consultor', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<PerfilPreInversionConsultoresBloc,
              PerfilPreInversionConsultoresState>(builder: (context, state) {
            if (state is PerfilPreInversionConsultoresLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            }
            if (state is PerfilPreInversionConsultoresLoaded) {
              final perfilPreInversionConsultoresLoaded =
                  state.perfilPreInversionConsultoresLoaded!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      horizontalMargin: 3,
                      columnSpacing: 10,
                      headingRowColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      columns: <DataColumn>[
                        DataColumn(
                          label: Container(),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text('Revisión',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text('Consultor',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text('Fecha Asignación',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text('Identificación',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(IconButton(
                              alignment: Alignment.centerLeft,
                              onPressed: () {
                                BlocProvider.of<
                                            PerfilPreInversionConsultoresBloc>(
                                        context)
                                    .add(DeletePerfilPreInversionConsultores(
                                        perfilPreInversionConsultoresLoaded[0]
                                            .perfilPreInversionId,
                                        perfilPreInversionConsultoresLoaded[0]
                                            .consultorId,
                                        '1'));
                              },
                              icon: const Icon(Icons.delete_forever))),
                          DataCell(Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                perfilPreInversionConsultoresLoaded[0]
                                    .revision!,
                              ))),
                          DataCell(Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(perfilPreInversionConsultoresLoaded[0]
                                  .consultor!))),
                          DataCell(Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(perfilPreInversionConsultoresLoaded[0]
                                  .fechaRevision
                                  .substring(0, 10)))),
                          DataCell(Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(perfilPreInversionConsultoresLoaded[0]
                                  .consultorId))),
                        ]),
                      ]),
                ),
              );
            }
            if (state is PerfilPreInversionConsultoresInitial) {
              return BlocBuilder<ConsultorCubit, ConsultorState>(
                builder: (context, state) {
                  if (state is ConsultoresLoading) {
                    return const CustomCircularProgress(
                        alignment: Alignment.center);
                  } else if (state is ConsultoresLoaded) {
                    List<ConsultorEntity> consultores =
                        state.consultoresLoaded!;
                    if (consultores.isEmpty) {
                      return const SizedBox(
                          child: Center(
                              child: NoDataSvg(title: 'No hay resultados')));
                    }
                    return PerfilPreInversionConsultoresRows(
                        consultores: consultores,
                        subtitleStyle: Styles.subtitleStyle);
                  }
                  return Container();
                },
              );
            }
            return Container();
          }),
        ]));
  }
}
