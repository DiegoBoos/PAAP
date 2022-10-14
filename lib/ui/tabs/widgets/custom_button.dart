import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  @required
  final String text;
  final Color primary;
  final Color secondary;
  final Function()? onPressed;

  const CustomButton(
      {Key? key,
      required this.icon,
      required this.text,
      this.primary = Colors.grey,
      this.secondary = Colors.blue,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          _CustomButtonBackground(icon, primary, secondary),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100, width: 40),
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Text(text,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
              const SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _CustomButtonBackground extends StatelessWidget {
  final IconData icon;
  final Color primary;
  final Color secondary;

  const _CustomButtonBackground(this.icon, this.primary, this.secondary);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [primary, secondary])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: -10,
              child: Icon(icon, size: 80, color: Colors.white.withOpacity(0.2)),
            )
          ],
        ),
      ),
    );
  }
}
