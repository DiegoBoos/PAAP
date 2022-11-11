import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/opcion_entity.dart';
import '../../../domain/repositories/opcion/opcion_repository_db.dart';
import '../../datasources/local/opcion/opcion_local_ds.dart';

class OpcionRepositoryDBImpl implements OpcionRepositoryDB {
  final OpcionLocalDataSource opcionLocalDataSource;

  OpcionRepositoryDBImpl({required this.opcionLocalDataSource});

  @override
  Future<Either<Failure, List<OpcionEntity>>> getOpcionesRepositoryDB(
      String criterioId) async {
    try {
      final opcionesDB = await opcionLocalDataSource.getOpcionesDB(criterioId);

      return Right(opcionesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveOpcionesRepositoryDB(
      List<OpcionEntity> opcionEntity) async {
    try {
      final opcionDB = await opcionLocalDataSource.saveOpciones(opcionEntity);
      return Right(opcionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
