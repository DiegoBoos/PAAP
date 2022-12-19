import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/slider/slider_cubit.dart';

class ImagesSlides extends StatefulWidget {
  final List<File> images;
  final PageController pageViewController;

  const ImagesSlides(this.images, this.pageViewController, {Key? key})
      : super(key: key);

  @override
  State<ImagesSlides> createState() => ImagesSlidesState();
}

class ImagesSlidesState extends State<ImagesSlides> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
            controller: widget.pageViewController,
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, int i) {
              final image = widget.images[i];

              return Image.file(
                File(image.path),
                fit: BoxFit.cover,
              );
            }),
        Dots(widget.images.length)
      ],
    );
  }
}

class Dots extends StatelessWidget {
  final int totalSlides;

  const Dots(this.totalSlides, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(totalSlides, (index) => Dot(index)).toList()),
      ),
    );
  }
}

class Dot extends StatefulWidget {
  final int index;

  const Dot(this.index, {Key? key}) : super(key: key);

  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot> {
  late Color color;
  late double size;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        if (state is ShowSlider) {
          if (state.sliderModel.currentPage >= widget.index - 0.5 &&
              state.sliderModel.currentPage <= widget.index + 0.5) {
            color = Theme.of(context).colorScheme.secondary;
            size = state.sliderModel.biggerBullet;
          } else {
            color = Colors.white;
            size = state.sliderModel.smallerBullet;
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          );
        }
        return Container();
      },
    );
  }
}
