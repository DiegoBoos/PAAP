part of 'slider_cubit.dart';

class SliderModel {
  final double currentPage;
  final double biggerBullet;
  final double smallerBullet;

  SliderModel({
    required this.currentPage,
    required this.biggerBullet,
    required this.smallerBullet,
  });

  SliderModel copyWith({
    double? currentPage,
    double? biggerBullet,
    double? smallerBullet,
  }) =>
      SliderModel(
        currentPage: currentPage ?? this.currentPage,
        biggerBullet: biggerBullet ?? this.biggerBullet,
        smallerBullet: smallerBullet ?? this.smallerBullet,
      );
}

abstract class SliderState extends Equatable {
  final SliderModel sliderModel;

  const SliderState({required this.sliderModel});

  @override
  List<Object?> get props => [sliderModel];
}

class SliderInitial extends SliderState {
  SliderInitial()
      : super(
            sliderModel: SliderModel(
                currentPage: 0, biggerBullet: 17, smallerBullet: 12));
}

class ShowSlider extends SliderState {
  final SliderModel showSlider;
  const ShowSlider(this.showSlider) : super(sliderModel: showSlider);
}
