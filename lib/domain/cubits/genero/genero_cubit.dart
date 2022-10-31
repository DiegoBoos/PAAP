import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/genero_entity.dart';
import '../../usecases/genero/genero_db_usecase.dart';
import '../../usecases/genero/genero_usecase.dart';

part '../genero/genero_state.dart';

class GeneroCubit extends Cubit<GeneroState> {
  final GeneroUsecase genero;
  final GeneroUsecaseDB generoDB;

  GeneroCubit({required this.genero, required this.generoDB})
      : super(GeneroInitial()) {
    getGeneroDB();
  }

  void getGeneroDB() async {
    final result = await generoDB.getGenerosUsecaseDB();
    result.fold((failure) => emit(GeneroError(failure.properties.first)),
        (data) => emit(GeneroLoaded(data)));
  }
}
