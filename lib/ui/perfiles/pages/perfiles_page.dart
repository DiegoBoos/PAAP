import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/entities/v_perfil_entity.dart';
import '../../utils/sync_pages.dart';
import '../../utils/no_data_svg.dart';
import '../widgets/perfiles_rows.dart';

class PerfilesPage extends StatelessWidget {
  const PerfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<PerfilesBloc, PerfilesState>(
        builder: (context, state) {
          if (state is PerfilesLoading) {
            return const CustomCircularProgress(alignment: Alignment.center);
          } else if (state is PerfilesLoaded) {
            List<VPerfilEntity> vPerfiles = state.perfilesLoaded!;
            if (vPerfiles.isEmpty) {
              return const SizedBox(
                  child: Center(child: NoDataSvg(title: 'No hay resultados')));
            }
            return PerfilesRows(vPerfiles: vPerfiles);
          }
          return Container();
        },
      ),
    ));
  }
}
