import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/actividad_economica_entity.dart';
import '../../repositories/actividad_economica/actividad_economica_repository_db.dart';

class ActividadEconomicaUsecaseDB {
  final ActividadEconomicaRepositoryDB repositoryDB;

  ActividadEconomicaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ActividadEconomicaEntity>?>>
      getActividadEconomicasUsecaseDB() {
    return repositoryDB.getActividadesEconomicasRepositoryDB();
  }

  Future<Either<Failure, int>> saveActividadesEconomicasUsecaseDB(
      List<ActividadEconomicaEntity> actividadEconomicaEntity) {
    return repositoryDB
        .saveActividadesEconomicasRepositoryDB(actividadEconomicaEntity);
  }
}
