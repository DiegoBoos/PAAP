import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_tenencia_entity.dart';
import '../../repositories/tipo_tenencia/tipo_tenencia_repository_db.dart';

class TipoTenenciaUsecaseDB {
  final TipoTenenciaRepositoryDB repositoryDB;

  TipoTenenciaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoTenenciaEntity>?>>
      getTiposTenenciasUsecaseDB() {
    return repositoryDB.getTiposTenenciasRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposTenenciasUsecaseDB(
      List<TipoTenenciaEntity> tipotenenciaEntity) {
    return repositoryDB.saveTiposTenenciasRepositoryDB(tipotenenciaEntity);
  }
}
