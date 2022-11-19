import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_local_ds.dart';

class PerfilPreInversionCofinanciadorRubroRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorRubroRepositoryDB {
  final PerfilPreInversionCofinanciadorRubroLocalDataSource
      perfilPreInversionCofinanciadorRubroLocalDataSource;

  PerfilPreInversionCofinanciadorRubroRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorRubroLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorRubrosDB =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilPreInversionCofinanciadorRubrosDB();

      return Right(perfilPreInversionCofinanciadorRubrosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroRepositoryDB(String id) async {
    try {
      final perfilPreInversionCofinanciadorRubroDB =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilPreInversionCofinanciadorRubroDB(id);

      return Right(perfilPreInversionCofinanciadorRubroDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubroEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorRubroLocalDataSource
          .savePerfilPreInversionCofinanciadorRubros(
              perfilPreInversionCofinanciadorRubroEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>?>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorRepositoryDB(
          String cofinanciadorId) async {
    try {
      final result = await perfilPreInversionCofinanciadorRubroLocalDataSource
          .getPerfilPreInversionCofinanciadorRubrosByCofinanciadorDB(
              cofinanciadorId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
