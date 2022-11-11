import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/repositories/agrupacion/agrupacion_repository_db.dart';
import '../../datasources/local/agrupacion/agrupacion_local_ds.dart';

class AgrupacionRepositoryDBImpl implements AgrupacionRepositoryDB {
  final AgrupacionLocalDataSource agrupacionLocalDataSource;

  AgrupacionRepositoryDBImpl({required this.agrupacionLocalDataSource});

  @override
  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesRepositoryDB(
      String convocatoriaId) async {
    try {
      final agrupacionesDB =
          await agrupacionLocalDataSource.getAgrupacionesDB(convocatoriaId);

      return Right(agrupacionesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAgrupacionesRepositoryDB(
      List<AgrupacionEntity> agrupacionEntity) async {
    try {
      final agrupacionDB =
          await agrupacionLocalDataSource.saveAgrupaciones(agrupacionEntity);
      return Right(agrupacionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
