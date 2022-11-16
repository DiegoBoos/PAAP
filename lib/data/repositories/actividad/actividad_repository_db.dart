import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/actividad_entity.dart';
import '../../../domain/repositories/actividad/actividad_repository_db.dart';
import '../../datasources/local/actividad/actividad_local_ds.dart';

class ActividadRepositoryDBImpl implements ActividadRepositoryDB {
  final ActividadLocalDataSource actividadLocalDataSource;

  ActividadRepositoryDBImpl({required this.actividadLocalDataSource});

  @override
  Future<Either<Failure, List<ActividadEntity>>>
      getActividadesRepositoryDB() async {
    try {
      final actividadesDB = await actividadLocalDataSource.getActividadesDB();

      return Right(actividadesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, ActividadEntity?>> getActividadRepositoryDB(
      String id) async {
    try {
      final actividadDB = await actividadLocalDataSource.getActividadDB(id);

      return Right(actividadDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveActividadesRepositoryDB(
      List<ActividadEntity> actividadEntity) async {
    try {
      final actividadDB =
          await actividadLocalDataSource.saveActividades(actividadEntity);
      return Right(actividadDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
