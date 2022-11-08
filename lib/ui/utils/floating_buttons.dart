import 'package:flutter/material.dart';

class SaveFinishCancelButtons extends StatelessWidget {
  const SaveFinishCancelButtons({
    Key? key,
    required this.onCanceled,
    required this.onFinished,
    required this.onSaved,
  }) : super(key: key);

  final Function()? onCanceled;
  final Function()? onFinished;
  final Function()? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'btn-cancel',
          backgroundColor: Colors.red,
          onPressed: onCanceled,
          child: const Icon(Icons.cancel),
        ),
        const SizedBox(width: 5),
        FloatingActionButton(
          heroTag: 'btn-finish',
          onPressed: onFinished,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.send),
        ),
        const SizedBox(width: 5),
        FloatingActionButton(
          heroTag: 'btn-save',
          onPressed: onSaved,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.save),
        ),
      ]),
    );
  }
}

class SaveBackButtons extends StatelessWidget {
  const SaveBackButtons({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  final Function()? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'btn-save',
          onPressed: onSaved,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.save),
        ),
        const SizedBox(width: 5),
        FloatingActionButton(
          heroTag: 'btn-back',
          onPressed: () => Navigator.pop(context),
          backgroundColor: Colors.grey,
          child: const Icon(Icons.arrow_back),
        ),
      ]),
    );
  }
}
