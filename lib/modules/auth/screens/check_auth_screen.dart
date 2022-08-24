import 'package:flutter/material.dart';
import 'package:paap/modules/auth/auth_exports.dart';
import 'package:paap/utils/secure_storage.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: SecureStorage.readToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();

              if (snapshot.data == '') {
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SignInScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                });
              } else {
                /*  Future.microtask(() {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HomeScreen(),
                          transitionDuration: const Duration(seconds: 0)));
                }); */
              }
              return Container();
            }),
      ),
    );
  }
}
