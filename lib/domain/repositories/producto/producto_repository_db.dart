import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/producto_entity.dart';

abstract class ProductoRepositoryDB {
  Future<Either<Failure, List<ProductoEntity>>> getProductosRepositoryDB();

  Future<Either<Failure, int>> saveProductosRepositoryDB(
      List<ProductoEntity> productoEntity);
}
