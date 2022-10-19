import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/input_decoration.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class PerfilesPage extends StatelessWidget {
  const PerfilesPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              dividerThickness: 0,
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text('ID',
                        style: subtitleStyle.copyWith(color: Colors.white)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Nombre',
                        style: subtitleStyle.copyWith(color: Colors.white)),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text(''),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    const DataCell(Text('1')),
                    const DataCell(Text('Asociacion de mujeres campesinas')),
                    DataCell(IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_right,
                        ))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    const DataCell(Text('2')),
                    const DataCell(Text('Asociación De Usuarios Campesinos')),
                    DataCell(IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_right,
                        ))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    const DataCell(Text('3')),
                    const DataCell(
                        Text('Producción Y Comercialización De Cachama')),
                    DataCell(IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_right,
                        ))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ]));
  }
}
