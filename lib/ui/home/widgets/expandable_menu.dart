import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../perfil/pages/search_perfil.dart';
import '../../preinversion/pages/search_perfil_preinversion.dart';
import '../../utils/background_colors.dart';
import '../pages/home_page.dart';
import 'custom_button.dart';

class ExpandableMenu extends StatelessWidget {
  const ExpandableMenu({
    Key? key,
    this.isSimpleList = false,
  }) : super(key: key);

  final bool isSimpleList;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      /* Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Image.asset('assets/logo-ruta-al-sur.jpeg'),
      ), */

      FadeInRight(
        child: ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const HomePage())))),
      ),
      FadeInLeft(
        child: ExpansionTile(
            leading: const Icon(Icons.group, size: 40),
            title: const Text('Perfiles',
                style: TextStyle(
                  fontSize: 18,
                )),
            tilePadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: perfilesButtons(context)),
      ),
      FadeInRight(
          child: ExpansionTile(
              leading: const Icon(Icons.filter_center_focus, size: 40),
              title: const Text('Preinversión',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              tilePadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: preinversionButtons(context))),
      FadeInRight(
        child: ExpansionTile(
            leading: const Icon(Icons.perm_contact_calendar, size: 40),
            title: const Text('Alianzas',
                style: TextStyle(
                  fontSize: 18,
                )),
            tilePadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: alianzasButtons(context)),
      ),
      FadeInLeft(
        child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () => BlocProvider.of<AuthBloc>(context, listen: false)
                .add(LogOut())),
      )
    ]);
  }

  List<Widget> perfilesButtons(BuildContext context) {
    !isSimpleList
        ? [
            CustomButton(
                icon: Icons.search,
                text: 'Listar Perfiles',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: () =>
                    showSearch(context: context, delegate: SearchPerfil())),
            const CustomButton(
                icon: Icons.assignment_turned_in,
                text: 'Registro primera visita',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
          ]
        : [
            ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Listar Perfiles'),
                onTap: () =>
                    showSearch(context: context, delegate: SearchPerfil())),
            const ListTile(
                leading: Icon(Icons.assignment_turned_in),
                title: Text('Registro primera visita'),
                onTap: null)
          ];

    return [];
  }

  List<Widget> preinversionButtons(BuildContext context) {
    !isSimpleList
        ? [
            CustomButton(
                icon: Icons.search,
                text: 'Listar Perfiles',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: () => showSearch(
                    context: context, delegate: SearchPerfilPreinversion())),
            const CustomButton(
                icon: Icons.sentiment_very_satisfied,
                text: 'Beneficiarios',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
            const CustomButton(
                icon: Icons.accessibility,
                text: 'Aliados',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
            const CustomButton(
                icon: Icons.add_to_photos,
                text: 'Cofinanciadores',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
            const CustomButton(
                icon: Icons.touch_app,
                text: 'Asignar Consultor',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
            const CustomButton(
                icon: Icons.attach_money,
                text: 'Modelo Financiero',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null)
          ]
        : [
            ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Listar Perfiles'),
                onTap: () => showSearch(
                    context: context, delegate: SearchPerfilPreinversion())),
            const ListTile(
                leading: Icon(Icons.sentiment_very_satisfied),
                title: Text('Beneficiarios'),
                onTap: null),
            const ListTile(
                leading: Icon(Icons.accessibility),
                title: Text('Aliados'),
                onTap: null),
            const ListTile(
                leading: Icon(Icons.add_to_photos),
                title: Text('Cofinanciadores'),
                onTap: null),
            const ListTile(
                leading: Icon(Icons.touch_app),
                title: Text('Asignar Consultor'),
                onTap: null),
            const ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Modelo Financiero'),
                onTap: null)
          ];

    return [];
  }

  List<Widget> alianzasButtons(BuildContext context) {
    !isSimpleList
        ? [
            CustomButton(
                icon: Icons.search,
                text: 'Listar Alianzas',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: () => showSearch(
                    context: context, delegate: SearchPerfilPreinversion())),
            const CustomButton(
                icon: Icons.sentiment_very_satisfied,
                text: 'Beneficiarios',
                primary: HomeUtils.lightGreen,
                secondary: HomeUtils.green,
                onPressed: null),
          ]
        : [
            const ListTile(
                leading: Icon(Icons.search),
                title: Text('Listar Alianzas'),
                onTap: null),
            const ListTile(
                leading: Icon(Icons.sentiment_very_satisfied),
                title: Text('Beneficiarios'),
                onTap: null),
          ];
    return [];
  }
}
