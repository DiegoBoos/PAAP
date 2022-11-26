import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/actividad_economica_entity.dart';
import '../../../domain/repositories/actividad_economica/actividad_economica_repository_db.dart';
import '../../datasources/local/actividad_economica_local_ds.dart';

class ActividadEconomicaRepositoryDBImpl
    implements ActividadEconomicaRepositoryDB {
  final ActividadEconomicaLocalDataSource actividadEconomicaLocalDataSource;

  ActividadEconomicaRepositoryDBImpl(
      {required this.actividadEconomicaLocalDataSource});

  @override
  Future<Either<Failure, List<ActividadEconomicaEntity>>>
      getActividadesEconomicasRepositoryDB() async {
    try {
      final actividadesEconomicasDB =
          await actividadEconomicaLocalDataSource.getActividadesEconomicasDB();

      return Right(actividadesEconomicasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveActividadesEconomicasRepositoryDB(
      List<ActividadEconomicaEntity> actividadEconomicaEntity) async {
    try {
      final actividadEconomicaDB = await actividadEconomicaLocalDataSource
          .saveActividadesEconomicas(actividadEconomicaEntity);
      return Right(actividadEconomicaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
