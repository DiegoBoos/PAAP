import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../utils/background_colors.dart';

class HomeBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? image;

  const HomeBanner({
    Key? key,
    required this.title,
    required this.subtitle,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HomeUtils.green, HomeUtils.lightGreen]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: FadeInLeft(
                    child: Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*  Container(
            margin: const EdgeInsets.only(right: 20),
            child: BounceInDown(
              delay: const Duration(milliseconds: 500),
              child: Image.asset(
                image,
                height: 100,
              ),
            ),
          ) */
        ],
      ),
    );
  }
}
