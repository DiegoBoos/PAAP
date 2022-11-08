import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/genero_entity.dart';
import '../../usecases/genero/genero_db_usecase.dart';

part '../genero/genero_state.dart';

class GeneroCubit extends Cubit<GeneroState> {
  final GeneroUsecaseDB generoDB;

  GeneroCubit({required this.generoDB}) : super(GenerosInitial()) {
    getGenerosDB();
  }

  void getGenerosDB() async {
    final result = await generoDB.getGenerosUsecaseDB();
    result.fold((failure) => emit(GenerosError(failure.properties.first)),
        (data) => emit(GenerosLoaded(data)));
  }
}
