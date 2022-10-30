import 'package:flutter/material.dart';
import '../../utils/network_icon.dart';

class PreinversionPage extends StatefulWidget {
  const PreinversionPage({super.key});

  @override
  State<PreinversionPage> createState() => _PreinversionPageState();
}

class _PreinversionPageState extends State<PreinversionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preinversion'),
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
