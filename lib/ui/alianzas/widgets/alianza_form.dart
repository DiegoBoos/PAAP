import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/v_alianza/v_alianza_cubit.dart';
import '../../utils/input_decoration.dart';

class AlianzaForm extends StatelessWidget {
  const AlianzaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VAlianzaCubit, VAlianzaState>(
      builder: (context, state) {
        if (state is VAlianzaSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.alianzaId,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'ID Alianza', labelText: 'ID Alianza')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      state.vPerfilPreInversionSelected!.perfilPreInversionId,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'ID Perfil PreInversion',
                      labelText: 'ID Perfil PreInversion')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.nombre,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la alianza',
                      labelText: 'Nombre de la alianza')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.nit,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nit', labelText: 'Nit')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.tipoProyecto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      state.vPerfilPreInversionSelected!.productoPrincipal,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Principal',
                      labelText: 'Producto Principal')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue:
                      state.vPerfilPreInversionSelected!.productoAsociado,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Asociado',
                      labelText: 'Producto Asociado')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.municipio,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Municipio', labelText: 'Municipio')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.abreviatura,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Asociación',
                      labelText: 'Nombre de la Asociación')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.direccion,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Dirección', labelText: 'Dirección')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.contacto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: state.vPerfilPreInversionSelected!.correo,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            state.vPerfilPreInversionSelected!.telefonoFijo,
                        enabled: false,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            state.vPerfilPreInversionSelected!.telefonoMovil,
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
                        initialValue: state
                            .vPerfilPreInversionSelected!.valorTotalProyecto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Valor Total del Proyecto',
                            labelText: 'Valor Total del Proyecto')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            state.vPerfilPreInversionSelected!.incentivoModular,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Incentivo Modular',
                            labelText: 'Incentivo Modular')),
                  )
                ],
              ),
              SwitchListTile(
                title: const Text('Legalizado'),
                value: state.vPerfilPreInversionSelected!.legalizado == 'true'
                    ? true
                    : false,
                onChanged: null,
              ),
              const SizedBox(height: 20),
            ]),
          );
        }
        return Container();
      },
    );
  }
}
