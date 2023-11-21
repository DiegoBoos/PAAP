import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_identificacion_entity.dart';

abstract class TipoIdentificacionRepositoryDB {
  Future<Either<Failure, List<TipoIdentificacionEntity>>>
      getTiposIdentificacionesRepositoryDB();

  Future<Either<Failure, int>> saveTiposIdentificacionesRepositoryDB(
      List<TipoIdentificacionEntity> tipoidentificacionEntity);
}
