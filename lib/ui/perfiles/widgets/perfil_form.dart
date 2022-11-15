import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/v_perfil/v_perfil_cubit.dart';
import '../../utils/input_decoration.dart';

class PerfilForm extends StatelessWidget {
  const PerfilForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VPerfilCubit, VPerfilState>(
      builder: (context, state) {
        if (state is VPerfilSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              TextFormField(
                  initialValue: state.vPerfilSelected!.perfilId,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'ID Perfil', labelText: 'ID Perfil')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.nombre,
                  enabled: false,
                  maxLines: null,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del Proyecto',
                      labelText: 'Nombre del Proyecto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.tipoProyecto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.productoPrincipal,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Principal',
                      labelText: 'Producto Principal')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.productoAsociado,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Asociado',
                      labelText: 'Producto Asociado')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.departamento,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Departamento', labelText: 'Departamento')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.municipio,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Municipio', labelText: 'Municipio')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.abreviatura,
                  maxLines: null,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Asociación',
                      labelText: 'Nombre de la Asociación')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.direccion,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Dirección', labelText: 'Dirección')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.contacto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilSelected!.correo,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: state.vPerfilSelected!.telefonoFijo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: state.vPerfilSelected!.telefonoMovil,
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
                        initialValue: state.vPerfilSelected!.valorTotalProyecto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Valor Total del Proyecto',
                            labelText: 'Valor Total del Proyecto')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: state.vPerfilSelected!.incentivoModular,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Incentivo Modular',
                            labelText: 'Incentivo Modular')),
                  )
                ],
              )
            ]),
          );
        }
        return const SizedBox();
      },
    );
  }
}
