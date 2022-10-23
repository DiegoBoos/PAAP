import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataSvg extends StatelessWidget {
  const NoDataSvg({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SvgPicture.asset('assets/images/no-data.svg', height: 100),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
