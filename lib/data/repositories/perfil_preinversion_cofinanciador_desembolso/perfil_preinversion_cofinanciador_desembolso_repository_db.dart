import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_local_ds.dart';

class PerfilPreInversionCofinanciadorDesembolsoRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorDesembolsoRepositoryDB {
  final PerfilPreInversionCofinanciadorDesembolsoLocalDataSource
      perfilPreInversionCofinanciadorDesembolsoLocalDataSource;

  PerfilPreInversionCofinanciadorDesembolsoRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorDesembolsoLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorDesembolsosDB =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilPreInversionCofinanciadorDesembolsosDB();

      return Right(perfilPreInversionCofinanciadorDesembolsosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
          String id) async {
    try {
      final perfilPreInversionCofinanciadorDesembolsoDB =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilPreInversionCofinanciadorDesembolsoDB(id);

      return Right(perfilPreInversionCofinanciadorDesembolsoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsoEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .savePerfilPreInversionCofinanciadorDesembolsos(
                  perfilPreInversionCofinanciadorDesembolsoEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
