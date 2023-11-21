import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/tipo_visita_entity.dart';
import '../../repositories/tipo_visita/tipo_visita_repository_db.dart';

class TipoVisitaUsecaseDB {
  final TipoVisitaRepositoryDB repositoryDB;

  TipoVisitaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoVisitaEntity>?>> getTiposVisitasUsecaseDB() {
    return repositoryDB.getTiposVisitasRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposVisitasUsecaseDB(
      List<TipoVisitaEntity> tipovisitaEntity) {
    return repositoryDB.saveTiposVisitasRepositoryDB(tipovisitaEntity);
  }
}
