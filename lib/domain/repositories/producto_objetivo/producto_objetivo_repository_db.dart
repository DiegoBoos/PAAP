import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/producto_objetivo_entity.dart';

abstract class ProductoObjetivoRepositoryDB {
  Future<Either<Failure, List<ProductoObjetivoEntity>>>
      getProductosObjetivosRepositoryDB();

  Future<Either<Failure, int>> saveProductosObjetivosRepositoryDB(
      List<ProductoObjetivoEntity> productoObjetivoEntity);
}
