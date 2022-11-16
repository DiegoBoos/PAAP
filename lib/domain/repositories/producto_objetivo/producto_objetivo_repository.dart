import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/producto_objetivo_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ProductoObjetivoRepository {
  Future<Either<Failure, List<ProductoObjetivoEntity>>>
      getProductosObjetivosRepository(UsuarioEntity usuario);
}
