import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showCustomAlert(
      String title, String msg, int? statusCode, IconData icon, Color color) {
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(
            title: title,
            msg: msg,
            statusCode: statusCode,
            icon: icon,
            color: color,
          );
        });
  }

  static showSnackBar(String msg, [Color? backgroundColor = Colors.green]) {
    final snackBar = SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String msg;
  final int? statusCode;
  final IconData icon;
  final Color color;
  const CustomDialog({
    Key? key,
    required this.title,
    required this.msg,
    this.statusCode,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Icon(
                  icon,
                  size: 90,
                  color: color,
                )),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            msg,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 15),
                  )),
              TextButton(
                  onPressed: statusCode == 401
                      ? () => invalidToken(context)
                      : () => Navigator.of(context).pop(),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 15),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  static void invalidToken(BuildContext context) {
    /* final authService = Provider.of<AuthService>(context, listen: false);
    authService.logout();

    Navigator.pushReplacementNamed(context, 'sign-in'); */
  }
}
