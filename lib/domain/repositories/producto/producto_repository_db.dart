import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/producto_entity.dart';

abstract class ProductoRepositoryDB {
  Future<Either<Failure, List<ProductoEntity>>> getProductosRepositoryDB(
      String perfilPreInversionId);

  Future<Either<Failure, int>> saveProductosRepositoryDB(
      List<ProductoEntity> productoEntity);
}
