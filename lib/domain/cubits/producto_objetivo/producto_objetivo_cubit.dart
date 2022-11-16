import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/producto_objetivo_entity.dart';
import '../../usecases/producto_objetivo/producto_objetivo_db_usecase.dart';

part '../producto_objetivo/producto_objetivo_state.dart';

class ProductoObjetivoCubit extends Cubit<ProductoObjetivoState> {
  final ProductoObjetivoUsecaseDB productoObjetivoDB;

  ProductoObjetivoCubit({required this.productoObjetivoDB})
      : super(ProductosObjetivosInitial()) {
    getProductosObjetivosDB();
  }

  void getProductosObjetivosDB() async {
    final result = await productoObjetivoDB.getProductosObjetivosUsecaseDB();
    result.fold(
        (failure) => emit(ProductosObjetivosError(failure.properties.first)),
        (data) => emit(ProductosObjetivosLoaded(data)));
  }
}
