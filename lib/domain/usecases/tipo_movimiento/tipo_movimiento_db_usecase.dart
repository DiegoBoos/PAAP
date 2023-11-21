import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/tipo_movimiento_entity.dart';
import '../../repositories/tipo_movimiento/tipo_movimiento_repository_db.dart';

class TipoMovimientoUsecaseDB {
  final TipoMovimientoRepositoryDB repositoryDB;

  TipoMovimientoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoMovimientoEntity>?>>
      getTiposMovimientosUsecaseDB() {
    return repositoryDB.getTiposMovimientosRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposMovimientosUsecaseDB(
      List<TipoMovimientoEntity> tipomovimientoEntity) {
    return repositoryDB.saveTiposMovimientosRepositoryDB(tipomovimientoEntity);
  }
}
