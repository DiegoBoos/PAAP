import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/producto_objetivo_entity.dart';
import '../../../domain/repositories/producto_objetivo/producto_objetivo_repository_db.dart';
import '../../datasources/local/producto_objetivo_local_ds.dart';

class ProductoObjetivoRepositoryDBImpl implements ProductoObjetivoRepositoryDB {
  final ProductoObjetivoLocalDataSource productoObjetivoLocalDataSource;

  ProductoObjetivoRepositoryDBImpl(
      {required this.productoObjetivoLocalDataSource});

  @override
  Future<Either<Failure, List<ProductoObjetivoEntity>>>
      getProductosObjetivosRepositoryDB() async {
    try {
      final productosObjetivosDB =
          await productoObjetivoLocalDataSource.getProductosObjetivosDB();

      return Right(productosObjetivosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveProductosObjetivosRepositoryDB(
      List<ProductoObjetivoEntity> productoObjetivoEntity) async {
    try {
      final productoObjetivoDB = await productoObjetivoLocalDataSource
          .saveProductosObjetivos(productoObjetivoEntity);
      return Right(productoObjetivoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
