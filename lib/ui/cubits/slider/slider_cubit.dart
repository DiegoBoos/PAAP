import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  showSlider(SliderModel sliderModel) {
    emit(ShowSlider(sliderModel));
  }
}
