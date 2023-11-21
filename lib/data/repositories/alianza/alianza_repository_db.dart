import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/alianza_entity.dart';
import '../../../domain/entities/v_alianza_entity.dart';
import '../../../domain/repositories/alianza/alianza_repository_db.dart';
import '../../datasources/local/alianzas_local_ds.dart';

class AlianzaRepositoryDBImpl implements AlianzaRepositoryDB {
  final AlianzasLocalDataSource alianzaLocalDataSource;

  AlianzaRepositoryDBImpl({required this.alianzaLocalDataSource});

  @override
  Future<Either<Failure, List<VAlianzaEntity>>>
      getAlianzasRepositoryDB() async {
    try {
      final alianzasDB = await alianzaLocalDataSource.getAlianzasDB();

      return Right(alianzasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<VAlianzaEntity>>> getAlianzasFiltrosRepositoryDB(
      String id, String nombre) async {
    try {
      final alianzasFiltrosDB =
          await alianzaLocalDataSource.getAlianzasFiltrosDB(id, nombre);

      return Right(alianzasFiltrosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzasRepositoryDB(
      List<AlianzaEntity> alianzaEntity) async {
    try {
      final result = await alianzaLocalDataSource.saveAlianzasDB(alianzaEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
