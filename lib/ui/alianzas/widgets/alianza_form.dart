import 'package:flutter/material.dart';

import '../../../domain/entities/v_alianza_entity.dart';
import '../../utils/input_decoration.dart';

class AlianzaForm extends StatelessWidget {
  const AlianzaForm({super.key, required this.alianza});
  final VAlianzaEntity alianza;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(children: [
        TextFormField(
            initialValue: alianza.alianzaId,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'ID Alianza', labelText: 'ID Alianza')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.perfilPreInversionId,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'ID Perfil PreInversion',
                labelText: 'ID Perfil PreInversion')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.nombre,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre de la alianza',
                labelText: 'Nombre de la alianza')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.nit,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nit', labelText: 'Nit')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.tipoProyecto,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.productoPrincipal,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Producto Principal',
                labelText: 'Producto Principal')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.productoAsociado,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Producto Asociado', labelText: 'Producto Asociado')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.municipio,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Municipio', labelText: 'Municipio')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.abreviatura,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre de la Asociación',
                labelText: 'Nombre de la Asociación')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.direccion,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Dirección', labelText: 'Dirección')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.contacto,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre del contacto',
                labelText: 'Nombre del contacto')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: alianza.correo,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Correo', labelText: 'Correo')),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                  initialValue: alianza.telefonoFijo,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Fijo', labelText: 'Teléfono Fijo')),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                  initialValue: alianza.telefonoMovil,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil')),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                  initialValue: alianza.valorTotalProyecto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Valor Total del Proyecto',
                      labelText: 'Valor Total del Proyecto')),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                  initialValue: alianza.incentivoModular,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Incentivo Modular',
                      labelText: 'Incentivo Modular')),
            )
          ],
        ),
        SwitchListTile(
          title: const Text('Legalizado'),
          value: alianza.legalizado == 'true' ? true : false,
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
