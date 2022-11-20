import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../domain/repositories/perfil_preinversion_consultor/perfil_preinversion_consultor_repository_db.dart';
import '../../datasources/local/perfil_preinversion_consultor/perfil_preinversion_consultor_local_ds.dart';

class PerfilPreInversionConsultorRepositoryDBImpl
    implements PerfilPreInversionConsultorRepositoryDB {
  final PerfilPreInversionConsultorLocalDataSource
      perfilPreInversionConsultorLocalDataSource;

  PerfilPreInversionConsultorRepositoryDBImpl(
      {required this.perfilPreInversionConsultorLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresRepositoryDB() async {
    try {
      final perfilPreInversionConsultoresDB =
          await perfilPreInversionConsultorLocalDataSource
              .getPerfilPreInversionConsultoresDB();

      return Right(perfilPreInversionConsultoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionConsultorEntity?>>
      getPerfilPreInversionConsultorRepositoryDB(String id) async {
    try {
      final perfilPreInversionConsultorDB =
          await perfilPreInversionConsultorLocalDataSource
              .getPerfilPreInversionConsultorDB(id);

      return Right(perfilPreInversionConsultorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionConsultoresRepositoryDB(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity) async {
    try {
      final result = await perfilPreInversionConsultorLocalDataSource
          .savePerfilPreInversionConsultores(perfilPreInversionConsultorEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilesPreInversionesConsultoresProduccionRepositoryDB() async {
    try {
      final perfilPreInversionConsultoresDB =
          await perfilPreInversionConsultorLocalDataSource
              .getPerfilesPreInversionesConsultoresProduccionDB();

      return Right(perfilPreInversionConsultoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionConsultorRepositoryDB(
      PerfilPreInversionConsultorEntity
          perfilPreInversionConsultorEntity) async {
    try {
      final perfilPreInversionConsultorDB =
          await perfilPreInversionConsultorLocalDataSource
              .savePerfilPreInversionConsultorDB(
                  perfilPreInversionConsultorEntity);
      return Right(perfilPreInversionConsultorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesConsultoresProduccionDBRepositoryDB(
          List<PerfilPreInversionConsultorEntity>
              perfilesPreInversionesConsultoresEntity) async {
    try {
      final result = await perfilPreInversionConsultorLocalDataSource
          .updatePerfilesPreInversionesConsultoresProduccionDB(
              perfilesPreInversionesConsultoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
