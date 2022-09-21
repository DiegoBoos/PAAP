import 'package:flutter/material.dart';

import '../../../domain/entities/perfil.dart';
import '../../utils/no_data_svg.dart';

class SearchPerfil extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar por ID o nombre';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return const NoDataSvg(title: 'Escriba para buscar');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const NoDataSvg(title: 'Escriba para buscar');
    }

    final periles = [
      PerfilEntity(
          projectName: 'Asociacion de mujeres campesinas EAT "PROFRUTAL"',
          asociationName:
              'GUAYABA - PALMAR DE VARELA -  MUJERES CAMPESINAS PROCESADORAS Y COMERCIALIDORAS DE FRUTAS PROFRUTAL ',
          address: 'calle 5 N° 11-112',
          contactName: 'KARILYS MARGARITA PIZARRO BARRIOS',
          email: 'karivan_25@hotmail.com')
    ];

    return ListView.separated(
        itemBuilder: (context, i) => _PerilTile(peril: periles[i]),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: periles.length);

    /*  return StreamBuilder<List<Driver>>(
      stream: driverService.readDrivers,
      builder: (BuildContext context, AsyncSnapshot<List<Driver>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          final drivers = snapshot.data!;
          if (drivers
              .where((Driver filteredDriver) => filterDrivers(filteredDriver))
              .isEmpty) {
            return const NoDataSvg(
                title: 'No hay resultados que coincidan con la búsqueda');
          }

          return ListView(children: [
            ...drivers
                .where((Driver filteredDriver) => filterDrivers(filteredDriver))
                .map((Driver driver) => _DriverTile(driver: driver))
          ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ); */
  }
}

class _PerilTile extends StatelessWidget {
  final PerfilEntity peril;

  const _PerilTile({required this.peril});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text('${peril.id}'),
        title: Text(peril.projectName),
        onTap: () =>
            Navigator.pushNamed(context, 'new-edit-peril', arguments: peril));
  }
}
