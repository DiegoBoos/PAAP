import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/estado_visita_entity.dart';

abstract class EstadoVisitaRepositoryDB {
  Future<Either<Failure, List<EstadoVisitaEntity>>>
      getEstadosVisitasRepositoryDB();

  Future<Either<Failure, int>> saveEstadosVisitasRepositoryDB(
      List<EstadoVisitaEntity> estadovisitaEntity);
}
