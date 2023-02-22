import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_PurpleBox(), child],
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height / 3,
      decoration: _purpleBackground(context),
      child: Stack(children: [
        Positioned(
          top: 90,
          left: 30,
          child: _Bubble(),
        ),
        Positioned(
          top: -40,
          left: 30,
          child: _Bubble(),
        ),
        Positioned(
          top: -50,
          right: -20,
          child: _Bubble(),
        ),
        Positioned(
          bottom: -50,
          left: 10,
          child: _Bubble(),
        ),
        Positioned(
          bottom: 120,
          right: 20,
          child: _Bubble(),
        ),
        _BackgroundImage()
      ]),
    );
  }

  BoxDecoration _purpleBackground(BuildContext context) {
    return BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary
        ]));
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Image.asset('assets/images/logo.png'),
    ));
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
