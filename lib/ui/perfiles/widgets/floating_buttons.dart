import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'btn-cancel',
          backgroundColor: Colors.red,
          onPressed: () {},
          child: const Icon(Icons.cancel),
        ),
        const SizedBox(width: 5),
        FloatingActionButton(
          heroTag: 'btn-finish',
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.send),
        ),
        const SizedBox(width: 5),
        FloatingActionButton(
          heroTag: 'btn-save',
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.save),
        ),
      ]),
    );
  }
}
