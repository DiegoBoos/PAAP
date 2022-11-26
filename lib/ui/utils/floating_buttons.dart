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
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
    ]);
  }
}

class SaveBackButtons extends StatelessWidget {
  const SaveBackButtons({
    Key? key,
    required this.onSaved,
    required this.routeName,
  }) : super(key: key);

  final Function()? onSaved;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      FloatingActionButton(
        heroTag: 'btn-save',
        onPressed: onSaved,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.save),
      ),
      const SizedBox(width: 5),
      FloatingActionButton(
        heroTag: 'btn-back',
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, routeName, (route) => false),
        backgroundColor: Colors.grey,
        child: const Icon(Icons.arrow_back),
      ),
    ]);
  }
}

class BackFloatingButton extends StatelessWidget {
  const BackFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        heroTag: 'btn-back',
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, 'tabs', (route) => false),
        backgroundColor: Colors.grey,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
