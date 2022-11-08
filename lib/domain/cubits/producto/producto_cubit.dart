import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/producto_entity.dart';
import '../../usecases/producto/producto_db_usecase.dart';

part 'producto_state.dart';

class ProductoCubit extends Cubit<ProductoState> {
  final ProductoUsecaseDB productoDB;

  ProductoCubit({required this.productoDB}) : super(ProductosInitial()) {
    getProductosDB();
  }

  void getProductosDB() async {
    final result = await productoDB.getProductosUsecaseDB();
    result.fold((failure) => emit(ProductosError(failure.properties.first)),
        (data) => emit(ProductosLoaded(data)));
  }
}
