import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../../domain/repositories/aliado_preinversion/aliado_preinversion_repository_db.dart';
import '../../datasources/local/aliado_preinversion/aliado_preinversion_local_ds.dart';

class AliadoPreinversionRepositoryDBImpl
    implements AliadoPreinversionRepositoryDB {
  final AliadoPreinversionLocalDataSource aliadoPreinversionLocalDataSource;

  AliadoPreinversionRepositoryDBImpl(
      {required this.aliadoPreinversionLocalDataSource});

  @override
  Future<Either<Failure, List<AliadoPreinversionEntity>>>
      getAliadosPreinversionRepositoryDB() async {
    try {
      final aliadosPreinversionDB =
          await aliadoPreinversionLocalDataSource.getAliadosPreinversionDB();

      return Right(aliadosPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AliadoPreinversionEntity?>>
      getAliadoPreinversionRepositoryDB(String id) async {
    try {
      final aliadoPreinversionDB =
          await aliadoPreinversionLocalDataSource.getAliadoPreinversionDB(id);

      return Right(aliadoPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAliadosPreinversionRepositoryDB(
      List<AliadoPreinversionEntity> aliadoPreinversionEntity) async {
    try {
      final result = await aliadoPreinversionLocalDataSource
          .saveAliadosPreinversion(aliadoPreinversionEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
