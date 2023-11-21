import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/actividad_financiera_entity.dart';
import '../../repositories/actividad_financiera/actividad_financiera_repository_db.dart';

class ActividadFinancieraUsecaseDB {
  final ActividadFinancieraRepositoryDB repositoryDB;

  ActividadFinancieraUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ActividadFinancieraEntity>?>>
      getActividadesFinancierasUsecaseDB() {
    return repositoryDB.getActividadesFinancierasRepositoryDB();
  }

  Future<Either<Failure, int>> saveActividadesFinancierasUsecaseDB(
      List<ActividadFinancieraEntity> actividadFinancieraEntity) {
    return repositoryDB
        .saveActividadesFinancierasRepositoryDB(actividadFinancieraEntity);
  }
}
