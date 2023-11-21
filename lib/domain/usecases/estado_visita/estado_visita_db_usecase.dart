import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/estado_visita_entity.dart';
import '../../repositories/estado_visita/estado_visita_repository_db.dart';

class EstadoVisitaUsecaseDB {
  final EstadoVisitaRepositoryDB repositoryDB;

  EstadoVisitaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<EstadoVisitaEntity>?>>
      getEstadosVisitasUsecaseDB() {
    return repositoryDB.getEstadosVisitasRepositoryDB();
  }

  Future<Either<Failure, int>> saveEstadosVisitasUsecaseDB(
      List<EstadoVisitaEntity> estadovisitaEntity) {
    return repositoryDB.saveEstadosVisitasRepositoryDB(estadovisitaEntity);
  }
}
