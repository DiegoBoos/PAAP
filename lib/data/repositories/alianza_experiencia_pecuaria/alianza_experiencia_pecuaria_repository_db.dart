import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../../domain/repositories/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_repository_db.dart';
import '../../datasources/local/alianza_experiencia_pecuaria_local_ds.dart';

class AlianzaExperienciaPecuariaRepositoryDBImpl
    implements AlianzaExperienciaPecuariaRepositoryDB {
  final AlianzaExperienciaPecuariaLocalDataSource
      alianzaExperienciaPecuariaLocalDataSource;

  AlianzaExperienciaPecuariaRepositoryDBImpl(
      {required this.alianzaExperienciaPecuariaLocalDataSource});

  @override
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasProduccionRepositoryDB() async {
    try {
      final alianzasExperienciasPecuariasDB =
          await alianzaExperienciaPecuariaLocalDataSource
              .getAlianzasExperienciasPecuariasProduccionDB();

      return Right(alianzasExperienciasPecuariasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasRepositoryDB() async {
    try {
      final alianzasExperienciasPecuariasDB =
          await alianzaExperienciaPecuariaLocalDataSource
              .getAlianzasExperienciasPecuariasDB();

      return Right(alianzasExperienciasPecuariasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AlianzaExperienciaPecuariaEntity?>>
      getAlianzaExperienciaPecuariaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId) async {
    try {
      final alianzaExperienciaPecuariaDB =
          await alianzaExperienciaPecuariaLocalDataSource
              .getAlianzaExperienciaPecuariaDB(
                  tipoActividadProductivaId, beneficiarioId);

      return Right(alianzaExperienciaPecuariaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzasExperienciasPecuariasRepositoryDB(
      List<AlianzaExperienciaPecuariaEntity>
          alianzaExperienciaPecuariaEntity) async {
    try {
      final alianzaExperienciaPecuariaDB =
          await alianzaExperienciaPecuariaLocalDataSource
              .saveAlianzasExperienciasPecuarias(
                  alianzaExperienciaPecuariaEntity);
      return Right(alianzaExperienciaPecuariaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzaExperienciaPecuariaRepositoryDB(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity) async {
    try {
      final alianzaExperienciaPecuariaDB =
          await alianzaExperienciaPecuariaLocalDataSource
              .saveAlianzaExperienciaPecuariaDB(
                  alianzaExperienciaPecuariaEntity);
      return Right(alianzaExperienciaPecuariaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updateAlianzasExperienciasPecuariasProduccionDBRepositoryDB(
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity) async {
    try {
      final result = await alianzaExperienciaPecuariaLocalDataSource
          .updateAlianzasExperienciasPecuariasProduccionDB(
              alianzasExperienciasPecuariasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
