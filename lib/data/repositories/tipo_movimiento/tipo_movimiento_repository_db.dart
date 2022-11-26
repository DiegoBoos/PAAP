import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_movimiento_entity.dart';
import '../../../domain/repositories/tipo_movimiento/tipo_movimiento_repository_db.dart';
import '../../datasources/local/tipo_movimiento_local_ds.dart';

class TipoMovimientoRepositoryDBImpl implements TipoMovimientoRepositoryDB {
  final TipoMovimientoLocalDataSource tipoMovimientoLocalDataSource;

  TipoMovimientoRepositoryDBImpl({required this.tipoMovimientoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoMovimientoEntity>>>
      getTiposMovimientosRepositoryDB() async {
    try {
      final tipomovimientosDB =
          await tipoMovimientoLocalDataSource.getTiposMovimientosDB();

      return Right(tipomovimientosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposMovimientosRepositoryDB(
      List<TipoMovimientoEntity> tipomovimientoEntity) async {
    try {
      final tipomovimientoDB = await tipoMovimientoLocalDataSource
          .saveTiposMovimientos(tipomovimientoEntity);
      return Right(tipomovimientoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
