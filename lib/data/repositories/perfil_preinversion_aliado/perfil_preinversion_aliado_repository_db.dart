import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/repositories/perfil_preinversion_aliado/perfil_preinversion_aliado_repository_db.dart';
import '../../datasources/local/perfil_preinversion_aliado_local_ds.dart';

class PerfilPreInversionAliadoRepositoryDBImpl
    implements PerfilPreInversionAliadoRepositoryDB {
  final PerfilPreInversionAliadoLocalDataSource
      perfilPreInversionAliadoLocalDataSource;

  PerfilPreInversionAliadoRepositoryDBImpl(
      {required this.perfilPreInversionAliadoLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilesPreInversionesAliadosProduccionRepositoryDB() async {
    try {
      final perfilesPreInversionesAliadosDB =
          await perfilPreInversionAliadoLocalDataSource
              .getPerfilesPreInversionesAliadosProduccion();

      return Right(perfilesPreInversionesAliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilPreInversionAliadosDB =
          await perfilPreInversionAliadoLocalDataSource
              .getPerfilPreInversionAliadosDB(perfilPreInversionId);

      return Right(perfilPreInversionAliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionAliadosRepositoryDB(
      List<PerfilPreInversionAliadoEntity>
          perfilPreInversionAliadoEntity) async {
    try {
      final result = await perfilPreInversionAliadoLocalDataSource
          .savePerfilPreInversionAliados(perfilPreInversionAliadoEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionAliadoRepositoryDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity) async {
    try {
      final perfilPreInversionAliadoDB =
          await perfilPreInversionAliadoLocalDataSource
              .savePerfilPreInversionAliado(perfilPreInversionAliadoEntity);
      return Right(perfilPreInversionAliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesAliadosProduccionDBRepositoryDB(
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity) async {
    try {
      final result = await perfilPreInversionAliadoLocalDataSource
          .updatePerfilesPreInversionesAliadosProduccion(
              perfilesPreInversionesAliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
