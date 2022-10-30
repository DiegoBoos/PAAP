import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';
import '../../utils/network_icon.dart';

class AlianzasPage extends StatefulWidget {
  const AlianzasPage({super.key});

  @override
  State<AlianzasPage> createState() => _AlianzasPageState();
}

class _AlianzasPageState extends State<AlianzasPage> {
  List<MenuEntity> menuAlianzas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Alianzas'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: NetworkIcon(),
            )
          ],
        ),
        body: Container());
  }
}
