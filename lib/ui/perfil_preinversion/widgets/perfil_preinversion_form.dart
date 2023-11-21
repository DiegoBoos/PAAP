import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionForm extends StatelessWidget {
  const PerfilPreInversionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VPerfilPreInversionCubit, VPerfilPreInversionState>(
      builder: (context, state) {
        if (state is VPerfilPreInversionSelected) {
          final vPerfilPreinversionSelected =
              state.vPerfilPreInversionSelected!;
          return Column(children: [
            TextFormField(
                initialValue: vPerfilPreinversionSelected.perfilPreInversionId,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'ID. PreInversion',
                    labelText: 'ID. PreInversion')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.perfilId,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'ID Perfil', labelText: 'ID Perfil')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.convocatoria,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Convocatoria', labelText: 'Convocatoria')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.nombre,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre del Proyecto',
                    labelText: 'Nombre del Proyecto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.tipoProyecto,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.producto,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Producto Principal',
                    labelText: 'Producto Principal')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.productoAsociado,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Producto Asociado',
                    labelText: 'Producto Asociado')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.municipio,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Municipio', labelText: 'Municipio')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.abreviatura,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre de la Asociación',
                    labelText: 'Nombre de la Asociación')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.direccion,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Dirección', labelText: 'Dirección')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.contacto,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre del contacto',
                    labelText: 'Nombre del contacto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vPerfilPreinversionSelected.correo,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Correo', labelText: 'Correo')),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      initialValue: vPerfilPreinversionSelected.telefonoFijo,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Teléfono Fijo',
                          labelText: 'Teléfono Fijo')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue: vPerfilPreinversionSelected.telefonoMovil,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Teléfono Móvil',
                          labelText: 'Teléfono Móvil')),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      initialValue:
                          vPerfilPreinversionSelected.valorTotalProyecto,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Valor Total del Proyecto',
                          labelText: 'Valor Total del Proyecto')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue:
                          vPerfilPreinversionSelected.incentivoModular,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Incentivo Modular',
                          labelText: 'Incentivo Modular')),
                )
              ],
            ),
          ]);
        }
        return Container();
      },
    );
  }
}
