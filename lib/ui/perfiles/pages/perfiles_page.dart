import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/entities/perfil_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfiles_rows.dart';
import '../widgets/search_card.dart';

class PerfilesPage extends StatefulWidget {
  const PerfilesPage({super.key});

  @override
  State<PerfilesPage> createState() => _PerfilesPageState();
}

class _PerfilesPageState extends State<PerfilesPage> {
  @override
  void initState() {
    super.initState();
    final perfilesBloc = BlocProvider.of<PerfilesBloc>(context);
    perfilesBloc.add(GetPerfiles());
  }

  String? selectedValue;
  List<Map<String, dynamic>> options = [
    {'id': 'id', 'description': 'Filtrar por ID'},
    {'id': 'name', 'description': 'Filtrar por Nombre'},
    {'id': 'allFilters', 'description': 'Filtrar por ID y Nombre'},
  ];

  bool showCard = false;
  bool enableId = false;
  bool enableName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Perfiles'),
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
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilesLoaded) {
                List<PerfilEntity> perfiles = state.perfiles!;
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
        });
      },
    );
  }
}
