import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/producto_entity.dart';
import '../../../domain/repositories/producto/producto_repository_db.dart';
import '../../datasources/local/producto_local_ds.dart';

class ProductoRepositoryDBImpl implements ProductoRepositoryDB {
  final ProductoLocalDataSource productoLocalDataSource;

  ProductoRepositoryDBImpl({required this.productoLocalDataSource});

  @override
  Future<Either<Failure, List<ProductoEntity>>> getProductosRepositoryDB(
      String perfilPreInversionId) async {
    try {
      final productosDB =
          await productoLocalDataSource.getProductosDB(perfilPreInversionId);

      return Right(productosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveProductosRepositoryDB(
      List<ProductoEntity> productoEntity) async {
    try {
      final productoDB =
          await productoLocalDataSource.saveProductos(productoEntity);
      return Right(productoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
