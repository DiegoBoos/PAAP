import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_entidad_entity.dart';
import '../../repositories/tipo_entidad/tipo_entidad_repository_db.dart';

class TipoEntidadUsecaseDB {
  final TipoEntidadRepositoryDB repositoryDB;

  TipoEntidadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoEntidadEntity>?>>
      getTiposEntidadesUsecaseDB() {
    return repositoryDB.getTiposEntidadesRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposEntidadesUsecaseDB(
      List<TipoEntidadEntity> tipoEntidadEntity) {
    return repositoryDB.saveTiposEntidadesRepositoryDB(tipoEntidadEntity);
  }
}
