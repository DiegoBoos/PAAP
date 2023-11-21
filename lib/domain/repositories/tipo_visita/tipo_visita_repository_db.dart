import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_visita_entity.dart';

abstract class TipoVisitaRepositoryDB {
  Future<Either<Failure, List<TipoVisitaEntity>>> getTiposVisitasRepositoryDB();

  Future<Either<Failure, int>> saveTiposVisitasRepositoryDB(
      List<TipoVisitaEntity> tipovisitaEntity);
}
