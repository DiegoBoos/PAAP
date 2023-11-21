import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_movimiento_entity.dart';

abstract class TipoMovimientoRepositoryDB {
  Future<Either<Failure, List<TipoMovimientoEntity>>>
      getTiposMovimientosRepositoryDB();

  Future<Either<Failure, int>> saveTiposMovimientosRepositoryDB(
      List<TipoMovimientoEntity> tipomovimientoEntity);
}
