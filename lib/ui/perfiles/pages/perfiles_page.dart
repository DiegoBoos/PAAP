import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/network_icon.dart';
import 'package:paap/ui/utils/no_data_svg.dart';
import 'package:paap/ui/utils/styles.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/blocs/menu/menu_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../../domain/entities/perfiles_entity.dart';
import '../../utils/custom_drawer.dart';
import '../widgets/perfiles_rows.dart';
import '../widgets/search_card.dart';

class PerfilesPage extends StatefulWidget {
  const PerfilesPage({super.key, this.menuHijo});
  final List<MenuEntity>? menuHijo;

  @override
  State<PerfilesPage> createState() => _PerfilesPageState();
}

class _PerfilesPageState extends State<PerfilesPage> {
  @override
  void initState() {
    super.initState();
    initMenuPerfiles();
    getPerfiles();
  }

  void initMenuPerfiles() {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    menuPerfiles = menuBloc.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '12' &&
            (submenu.menuId == '22' || submenu.menuId == '31'))
        .toList();

    menuPerfiles.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
  }

  void getPerfiles() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final perfilesBloc = BlocProvider.of<PerfilesBloc>(context);

    if (internetCubit.state is InternetConnected) {
      perfilesBloc.add(GetPerfiles(usuario: authBloc.state.usuario!));
    } else if (internetCubit.state is InternetDisconnected) {
      perfilesBloc
          .add(GetPerfiles(usuario: authBloc.state.usuario!, isOffline: true));
    }
  }

  List<MenuEntity> menuPerfiles = [];
  String? selectedValue;
  List<Map<String, dynamic>> options = [
    {'id': 'id', 'description': 'Filtrar por ID'},
    {'id': 'name', 'description': 'Filtrar por Nombre'},
    {'id': 'allFilters', 'description': 'Filtrar por ID y Nombre'},
    {'id': 'listAll', 'description': 'Listar todo'},
  ];

  bool showCard = false;
  bool enableId = false;
  bool enableName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Perfiles'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        drawer: CustomDrawer(
          menuHijo: menuPerfiles,
        ),
        body: ListView(children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('PERFILES', style: Styles.titleStyle),
                filtersDropdown(context),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          if (showCard) SearchCard(enableId: enableId, enableName: enableName),
          BlocBuilder<PerfilesBloc, PerfilesState>(
            builder: (context, state) {
              if (state is PerfilesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PerfilesError) {
                return const SizedBox();
              } else if (state is PerfilesLoaded) {
                List<PerfilesEntity> perfiles = state.perfiles!;
                if (perfiles.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilesRows(
                    perfiles: perfiles, subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }

  DropdownButton<Object> filtersDropdown(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      icon: Icon(
        Icons.filter_alt,
        color: Theme.of(context).buttonTheme.colorScheme!.primary,
      ),
      items: options.map((Map<String, dynamic> options) {
        return DropdownMenuItem(
          value: options['id'],
          child: Text(options['description']),
        );
      }).toList(),
      onChanged: (Object? value) {
        setState(() {
          selectedValue = value as String;
          if (selectedValue == 'id') {
            showCard = true;
            enableId = true;
            enableName = false;
          }
          if (selectedValue == 'name') {
            showCard = true;
            enableName = true;
            enableId = false;
          }
          if (selectedValue == 'allFilters') {
            showCard = true;
            enableName = true;
            enableId = true;
          }
          if (selectedValue == 'listAll') {
            showCard = false;
            getPerfiles();
          }
        });
      },
    );
  }
}
