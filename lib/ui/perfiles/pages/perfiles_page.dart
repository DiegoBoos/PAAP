import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/entities/v_perfil_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfiles_rows.dart';
import '../../utils/search_card.dart';

class PerfilesPage extends StatefulWidget {
  const PerfilesPage({super.key});

  @override
  State<PerfilesPage> createState() => _PerfilesPageState();
}

class _PerfilesPageState extends State<PerfilesPage> {
  String? selectedValue;
  List<Map<String, dynamic>> options = [
    {'id': 'id', 'description': 'Filtrar por ID'},
    {'id': 'name', 'description': 'Filtrar por Nombre'},
  ];

  bool showCard = false;
  bool enableId = false;
  bool enableName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const NetworkIcon(),
            title: const Text('Perfiles'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: IconButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'sign-in'),
                    icon: const Icon(Icons.logout)),
              ),
            ]),
        body: ListView(children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text('PERFILES', style: Styles.titleStyle),
                ),
                Expanded(child: filtersDropdown(context)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          if (showCard)
            SearchCard(
                text: 'Perfil', enableId: enableId, enableName: enableName),
          BlocBuilder<PerfilesBloc, PerfilesState>(
            builder: (context, state) {
              if (state is PerfilesLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilesLoaded) {
                List<VPerfilEntity> vPerfiles = state.perfilesLoaded!;
                if (vPerfiles.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilesRows(
                    vPerfiles: vPerfiles, subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
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
        });
      },
    );
  }
}
