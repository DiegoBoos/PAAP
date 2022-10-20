import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/perfiles/perfiles_bloc.dart';
import 'package:paap/domain/entities/perfil_entity.dart';
import 'package:paap/ui/utils/input_decoration.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class PerfilesPage extends StatefulWidget {
  const PerfilesPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;

  @override
  State<PerfilesPage> createState() => _PerfilesPageState();
}

class _PerfilesPageState extends State<PerfilesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilesBloc = BlocProvider.of<PerfilesBloc>(context, listen: false);
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final internetCubit = BlocProvider.of<InternetCubit>(context, listen: true);
    if (internetCubit.state is InternetConnected) {
      perfilesBloc.add(GetPerfiles(
          usuarioId: authBloc.state.usuario!.usuarioId,
          contrasena: authBloc.state.usuario!.contrasena));
    } else {
      perfilesBloc.add(GetPerfiles(
          usuarioId: authBloc.state.usuario!.usuarioId,
          contrasena: authBloc.state.usuario!.contrasena,
          isOffline: true));
    }

    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);
    final menuHijo = menuCubit.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '12' &&
            (submenu.menuId == '22' || submenu.menuId == '31'))
        .toList();

    menuHijo.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });

    const titleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w500);
    const subtitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
    return Scaffold(
        appBar: AppBar(title: const Text('Perfiles')),
        drawer: CustomDrawer(menuHijo: menuHijo),
        body: ListView(children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('PERFILES', style: titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: subtitleStyle),
          ),
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(20),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filtros de búsqueda'),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        labelText: 'Buscar por ID del perfil',
                        hintText: 'Buscar por ID'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        labelText: 'Buscar por nombre del perfil',
                        hintText: 'Buscar Perfil'),
                  ),
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primary,
                        ),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.search)),
                      )),
                ],
              ),
            ),
          ),
          BlocBuilder<PerfilesBloc, PerfilesState>(
            builder: (context, state) {
              if (state is PerfilesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PerfilesError) {
                return const SizedBox();
              } else if (state is PerfilesLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    dividerThickness: 0,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text('ID',
                              style:
                                  subtitleStyle.copyWith(color: Colors.white)),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text('Nombre',
                              style:
                                  subtitleStyle.copyWith(color: Colors.white)),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(''),
                        ),
                      ),
                    ],
                    rows: List.generate(state.perfiles!.length, (index) {
                      PerfilEntity perfil = state.perfiles![index];

                      return DataRow(cells: <DataCell>[
                        DataCell(Text(perfil.perfilId)),
                        DataCell(Text(perfil.nombre)),
                        DataCell(IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                            ))),
                      ]);
                    }),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
