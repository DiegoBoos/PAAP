import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/producto_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ProductoRepository {
  Future<Either<Failure, List<ProductoEntity>>> getProductosRepository(
      UsuarioEntity usuario);
}
