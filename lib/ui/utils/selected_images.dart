import 'dart:io';

import 'package:flutter/material.dart';
import 'images_slides.dart';

class SelectedImages extends StatelessWidget {
  final List<File> images;
  final PageController pageViewController;

  const SelectedImages(
      {Key? key, required this.images, required this.pageViewController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: _buildBoxDecoration(),
      child: Opacity(
        opacity: 0.8,
        child: getImages(images),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

  Widget getImages(List<File>? images) {
    if (images!.isEmpty) {
      return const Image(
          image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }

    return ImagesSlides(images, pageViewController);
  }
}
