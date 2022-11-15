import 'package:flutter/material.dart';

class CustomGeneralDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmText;
  final String cancelText;
  final void Function()? onTapConfirm;
  final void Function()? onTapCancel;
  const CustomGeneralDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.cancelText,
    this.onTapConfirm,
    this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Divider(),
              GestureDetector(
                onTap: onTapConfirm,
                child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    confirmText,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapCancel,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(cancelText,
                      style: const TextStyle(
                          color: Color(0xff01579B), fontSize: 18),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
