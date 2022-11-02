import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitCircle(
            color: Colors.blue[900],
            size: 100.0,
          ),
          const SizedBox(height: 10),
          Text(title)
        ],
      ),
    );
  }
}

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key, required this.alignment});
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(alignment: alignment, child: CircularProgressIndicator());
  }
}
