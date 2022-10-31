import 'package:flutter/material.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress({
    Key? key,
    required this.progress,
    required this.title,
  }) : super(key: key);

  final double progress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LinearProgressIndicator(
            value: progress,
            valueColor:
                AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          buildLinearProgress(title, progress)
        ],
      ),
    );
  }
}

Widget buildLinearProgress(String title, double progress) {
  return Text(
    title + (progress * 100).toStringAsFixed(1),
    textAlign: TextAlign.center,
    style: const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
  );
}
