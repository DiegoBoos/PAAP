import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/producto_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/producto/producto_repository.dart';

class ProductoUsecase {
  final ProductoRepository repository;

  ProductoUsecase(this.repository);

  Future<Either<Failure, List<ProductoEntity>>> getProductosUsecase(
      UsuarioEntity usuario) {
    return repository.getProductosRepository(usuario);
  }
}
