import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/tipo_calidad_entity.dart';
import '../../repositories/tipo_calidad/tipo_calidad_repository_db.dart';

class TipoCalidadUsecaseDB {
  final TipoCalidadRepositoryDB repositoryDB;

  TipoCalidadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoCalidadEntity>?>>
      getTiposCalidadesUsecaseDB() {
    return repositoryDB.getTiposCalidadesRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposCalidadesUsecaseDB(
      List<TipoCalidadEntity> tipoCalidadEntity) {
    return repositoryDB.saveTiposCalidadesRepositoryDB(tipoCalidadEntity);
  }
}
