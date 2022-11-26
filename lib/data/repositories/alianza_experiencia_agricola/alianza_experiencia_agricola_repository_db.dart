import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../../domain/repositories/alianza_experiencia_agricola/alianza_experiencia_agricola_repository_db.dart';
import '../../datasources/local/alianza_experiencia_agricola_local_ds.dart';

class AlianzaExperienciaAgricolaRepositoryDBImpl
    implements AlianzaExperienciaAgricolaRepositoryDB {
  final AlianzaExperienciaAgricolaLocalDataSource
      alianzaExperienciaAgricolaLocalDataSource;

  AlianzaExperienciaAgricolaRepositoryDBImpl(
      {required this.alianzaExperienciaAgricolaLocalDataSource});

  @override
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasProduccionRepositoryDB() async {
    try {
      final alianzasExperienciasAgricolasDB =
          await alianzaExperienciaAgricolaLocalDataSource
              .getAlianzasExperienciasAgricolasProduccionDB();

      return Right(alianzasExperienciasAgricolasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasRepositoryDB() async {
    try {
      final alianzasExperienciasAgricolasDB =
          await alianzaExperienciaAgricolaLocalDataSource
              .getAlianzasExperienciasAgricolasDB();

      return Right(alianzasExperienciasAgricolasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AlianzaExperienciaAgricolaEntity?>>
      getAlianzaExperienciaAgricolaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId) async {
    try {
      final alianzaExperienciaAgricolaDB =
          await alianzaExperienciaAgricolaLocalDataSource
              .getAlianzaExperienciaAgricolaDB(
                  tipoActividadProductivaId, beneficiarioId);

      return Right(alianzaExperienciaAgricolaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzasExperienciasAgricolasRepositoryDB(
      List<AlianzaExperienciaAgricolaEntity>
          alianzaExperienciaAgricolaEntity) async {
    try {
      final alianzaExperienciaAgricolaDB =
          await alianzaExperienciaAgricolaLocalDataSource
              .saveAlianzasExperienciasAgricolasDB(
                  alianzaExperienciaAgricolaEntity);
      return Right(alianzaExperienciaAgricolaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzaExperienciaAgricolaRepositoryDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity) async {
    try {
      final alianzaExperienciaAgricolaDB =
          await alianzaExperienciaAgricolaLocalDataSource
              .saveAlianzaExperienciaAgricolaDB(
                  alianzaExperienciaAgricolaEntity);
      return Right(alianzaExperienciaAgricolaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updateAlianzasExperienciasAgricolasProduccionDBRepositoryDB(
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity) async {
    try {
      final result = await alianzaExperienciaAgricolaLocalDataSource
          .updateAlianzasExperienciasAgricolasProduccionDB(
              alianzasExperienciasAgricolasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
