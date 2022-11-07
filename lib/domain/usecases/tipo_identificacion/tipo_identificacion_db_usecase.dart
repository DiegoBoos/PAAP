import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_identificacion_entity.dart';
import '../../repositories/tipo_identificacion/tipo_identificacion_repository_db.dart';

class TipoIdentificacionUsecaseDB {
  final TipoIdentificacionRepositoryDB repositoryDB;

  TipoIdentificacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoIdentificacionEntity>?>>
      getTiposIdentificacionesUsecaseDB() {
    return repositoryDB.getTiposIdentificacionesRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposIdentificacionesUsecaseDB(
      List<TipoIdentificacionEntity> tipoIdentificacionEntity) {
    return repositoryDB
        .saveTiposIdentificacionesRepositoryDB(tipoIdentificacionEntity);
  }
}
