import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_discapacidad_entity.dart';
import '../../repositories/tipo_discapacidad/tipo_discapacidad_repository_db.dart';

class TipoDiscapacidadUsecaseDB {
  final TipoDiscapacidadRepositoryDB repositoryDB;

  TipoDiscapacidadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoDiscapacidadEntity>?>>
      getTiposDiscapacidadesUsecaseDB() {
    return repositoryDB.getTiposDiscapacidadesRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposDiscapacidadesUsecaseDB(
      List<TipoDiscapacidadEntity> tipoDiscapacidadEntity) {
    return repositoryDB
        .saveTiposDiscapacidadesRepositoryDB(tipoDiscapacidadEntity);
  }
}
