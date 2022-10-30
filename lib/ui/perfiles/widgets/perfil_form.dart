import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../utils/input_decoration.dart';

class PerfilForm extends StatefulWidget {
  const PerfilForm(
    this.perfilId, {
    Key? key,
  }) : super(key: key);

  final String perfilId;

  @override
  State<PerfilForm> createState() => _PerfilFormState();
}

class _PerfilFormState extends State<PerfilForm> {
  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final perfilesBloc = BlocProvider.of<PerfilesBloc>(context);
    perfilesBloc.add(
        GetPerfil(usuario: authBloc.state.usuario!, perfilId: widget.perfilId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilesBloc, PerfilesState>(
      builder: (context, state) {
        if (state is PerfilLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PerfilLoaded) {
          final perfil = state.perfilLoaded!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              TextFormField(
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'ID Alianza', labelText: 'ID Alianza')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.nombre,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del Proyecto',
                      labelText: 'Nombre del Proyecto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.tipoProyecto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Tipo Proyecto', labelText: 'Tipo Proyecto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.productoPrincipal,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Principal',
                      labelText: 'Producto Principal')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.productoAsociado,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Producto Asociado',
                      labelText: 'Producto Asociado')),
              const SizedBox(height: 20),
              TextFormField(
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Departamento', labelText: 'Departamento')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.municipio,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Municipio', labelText: 'Municipio')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.abreviatura,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Asociación',
                      labelText: 'Nombre de la Asociación')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.direccion,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Dirección', labelText: 'Dirección')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.contacto,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfil.correo,
                  enabled: false,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: perfil.telefonoFijo,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Teléfono Fijo',
                            labelText: 'Teléfono Fijo')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: perfil.telefonoMovil,
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
                        initialValue: perfil.valorTotalProyecto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Valor Total del Proyecto',
                            labelText: 'Valor Total del Proyecto')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: perfil.incentivoModular,
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
