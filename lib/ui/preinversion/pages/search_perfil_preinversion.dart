import 'package:flutter/material.dart';

import '../../utils/no_data_svg.dart';

class SearchPerfilPreinversion extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Perfiles Preinversión';

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

    return Container();

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
