import 'package:flutter/material.dart';

import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../utils/input_decoration.dart';

class PreinversionForm extends StatelessWidget {
  const PreinversionForm({super.key, required this.perfilPreinversion});
  final VPerfilPreinversionEntity perfilPreinversion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(children: [
        TextFormField(
            initialValue: perfilPreinversion.perfilPreInversionId,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'ID. Preinversion', labelText: 'ID. Preinversion')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.perfilId,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'ID Perfil', labelText: 'ID Perfil')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.convocatoria,
            enabled: false,
            maxLines: null,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Convocatoria', labelText: 'Convocatoria')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.nombre,
            enabled: false,
            maxLines: null,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre del Proyecto',
                labelText: 'Nombre del Proyecto')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.tipoProyecto,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.producto,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Producto Principal',
                labelText: 'Producto Principal')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.productoAsociado,
            enabled: false,
            maxLines: null,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Producto Asociado', labelText: 'Producto Asociado')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.municipio,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Municipio', labelText: 'Municipio')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.abreviatura,
            enabled: false,
            maxLines: null,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre de la Asociación',
                labelText: 'Nombre de la Asociación')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.direccion,
            enabled: false,
            maxLines: null,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Dirección', labelText: 'Dirección')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.contacto,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Nombre del contacto',
                labelText: 'Nombre del contacto')),
        const SizedBox(height: 20),
        TextFormField(
            initialValue: perfilPreinversion.correo,
            enabled: false,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Correo', labelText: 'Correo')),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                  initialValue: perfilPreinversion.telefonoFijo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Fijo', labelText: 'Teléfono Fijo')),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                  initialValue: perfilPreinversion.telefonoMovil,
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
                  initialValue: perfilPreinversion.valorTotalProyecto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Valor Total del Proyecto',
                      labelText: 'Valor Total del Proyecto')),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                  initialValue: perfilPreinversion.incentivoModular,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Incentivo Modular',
                      labelText: 'Incentivo Modular')),
            )
          ],
        )
      ]),
    );
  }
}
