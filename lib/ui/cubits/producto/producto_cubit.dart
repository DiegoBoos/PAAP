import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/producto_entity.dart';
import '../../../domain/usecases/producto/producto_db_usecase.dart';

part 'producto_state.dart';

class ProductoCubit extends Cubit<ProductoState> {
  final ProductoUsecaseDB productoDB;

  ProductoCubit({required this.productoDB}) : super(ProductosInitial());

  void getProductosDB(String perfilPreInversionId) async {
    final result = await productoDB.getProductosUsecaseDB(perfilPreInversionId);
    result.fold((failure) => emit(ProductosError(failure.properties.first)),
        (data) => emit(ProductosLoaded(data)));
  }
}
