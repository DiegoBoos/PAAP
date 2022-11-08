import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/alianzas/alianzas_bloc.dart';
import '../../../domain/entities/alianza_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/alianzas_rows.dart';
import '../widgets/search_card.dart';

class AlianzasPage extends StatefulWidget {
  const AlianzasPage({super.key});

  @override
  State<AlianzasPage> createState() => _AlianzasPageState();
}

class _AlianzasPageState extends State<AlianzasPage> {
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
            title: const Text('Alianzas'),
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
                const Text('ALIANZAS', style: Styles.titleStyle),
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
          BlocBuilder<AlianzasBloc, AlianzasState>(
            builder: (context, state) {
              if (state is AlianzasLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is AlianzasLoaded) {
                List<AlianzaEntity> alianzas = state.alianzasLoaded!;
                if (alianzas.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AlianzasRows(
                    alianzas: alianzas, subtitleStyle: Styles.subtitleStyle);
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
