import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/repositories/actividad_financiera/actividad_financiera_repository_db.dart';
import '../../datasources/local/actividad_financiera_local_ds.dart';

class ActividadFinancieraRepositoryDBImpl
    implements ActividadFinancieraRepositoryDB {
  final ActividadFinancieraLocalDataSource actividadFinancieraLocalDataSource;

  ActividadFinancieraRepositoryDBImpl(
      {required this.actividadFinancieraLocalDataSource});

  @override
  Future<Either<Failure, List<ActividadFinancieraEntity>>>
      getActividadesFinancierasRepositoryDB() async {
    try {
      final actividadesFinancierasDB = await actividadFinancieraLocalDataSource
          .getActividadesFinancierasDB();

      return Right(actividadesFinancierasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveActividadesFinancierasRepositoryDB(
      List<ActividadFinancieraEntity> actividadFinancieraEntity) async {
    try {
      final actividadFinancieraDB = await actividadFinancieraLocalDataSource
          .saveActividadesFinancieras(actividadFinancieraEntity);
      return Right(actividadFinancieraDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
