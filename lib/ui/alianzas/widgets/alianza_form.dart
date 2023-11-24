import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/v_alianza/v_alianza_cubit.dart';
import '../../utils/input_decoration.dart';

class AlianzaForm extends StatelessWidget {
  const AlianzaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VAlianzaCubit, VAlianzaState>(
      builder: (context, state) {
        if (state is VAlianzaSelected) {
          final vAlianzaSelected = state.vAlianzaSelected!;
          return Column(children: [
            TextFormField(
                initialValue: vAlianzaSelected.alianzaId,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'ID Alianza', labelText: 'ID Alianza')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.convocatoria,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Convocatoria', labelText: 'Convocatoria')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.nombre,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre del Proyecto',
                    labelText: 'Nombre del Proyecto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.tipoProyecto,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.productoPrincipal,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Producto Principal',
                    labelText: 'Producto Principal')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.productoAsociado,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Producto Asociado',
                    labelText: 'Producto Asociado')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.municipio,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Municipio', labelText: 'Municipio')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.abreviatura,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre de la Asociación',
                    labelText: 'Nombre de la Asociación')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.direccion,
                enabled: false,
                maxLines: null,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Dirección', labelText: 'Dirección')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.contacto,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Nombre del contacto',
                    labelText: 'Nombre del contacto')),
            const SizedBox(height: 20),
            TextFormField(
                initialValue: vAlianzaSelected.correo,
                enabled: false,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Correo', labelText: 'Correo')),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                      initialValue: vAlianzaSelected.telefonoFijo,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Teléfono Fijo',
                          labelText: 'Teléfono Fijo')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue: vAlianzaSelected.telefonoMovil,
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
                      initialValue: vAlianzaSelected.valorTotalProyecto,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Valor Total del Proyecto',
                          labelText: 'Valor Total del Proyecto')),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                      initialValue: vAlianzaSelected.incentivoModular,
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
