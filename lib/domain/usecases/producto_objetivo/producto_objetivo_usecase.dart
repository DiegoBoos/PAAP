import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/producto_objetivo_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/producto_objetivo/producto_Objetivo_repository.dart';

class ProductoObjetivoUsecase {
  final ProductoObjetivoRepository repository;

  ProductoObjetivoUsecase(this.repository);

  Future<Either<Failure, List<ProductoObjetivoEntity>>>
      getProductosObjetivosUsecase(UsuarioEntity usuario) {
    return repository.getProductosObjetivosRepository(usuario);
  }
}
