import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../utils/sync_pages.dart';
import '../../utils/no_data_svg.dart';
import 'perfiles_preinversion_rows.dart';

class PerfilesPreInversionPage extends StatefulWidget {
  const PerfilesPreInversionPage({super.key});

  @override
  State<PerfilesPreInversionPage> createState() =>
      _PerfilesPreInversionPageState();
}

class _PerfilesPreInversionPageState extends State<PerfilesPreInversionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<PerfilesPreInversionBloc, PerfilesPreInversionState>(
          builder: (context, state) {
            if (state is PerfilesPreInversionLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            } else if (state is PerfilesPreInversionLoaded) {
              List<VPerfilPreInversionEntity> vPerfilesPreInversion =
                  state.perfilesPreInversionLoaded!;
              if (vPerfilesPreInversion.isEmpty) {
                return const SizedBox(
                    child:
                        Center(child: NoDataSvg(title: 'No hay resultados')));
              }
              return PerfilesPreInversionRows(
                vPerfilesPreInversion: vPerfilesPreInversion,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
