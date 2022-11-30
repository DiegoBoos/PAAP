import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_repository_db.dart';
import '../../datasources/local/perfil_preinversion_beneficiario_local_ds.dart';

class PerfilPreInversionBeneficiarioRepositoryDBImpl
    implements PerfilPreInversionBeneficiarioRepositoryDB {
  final PerfilPreInversionBeneficiarioLocalDataSource
      perfilPreInversionBeneficiarioLocalDataSource;

  PerfilPreInversionBeneficiarioRepositoryDBImpl(
      {required this.perfilPreInversionBeneficiarioLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilesPreInversionesBeneficiariosProduccionRepositoryDB() async {
    try {
      final perfilesPreInversionesBeneficiariosDB =
          await perfilPreInversionBeneficiarioLocalDataSource
              .getPerfilesPreInversionesBeneficiariosProduccionDB();

      return Right(perfilesPreInversionesBeneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilPreInversionBeneficiariosDB =
          await perfilPreInversionBeneficiarioLocalDataSource
              .getPerfilPreInversionBeneficiariosDB(perfilPreInversionId);

      return Right(perfilPreInversionBeneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionBeneficiarioEntity?>>
      getPerfilPreInversionBeneficiarioRepositoryDB(
          String perfilPreInversionId, String beneficiarioId) async {
    try {
      final perfilPreInversionBeneficiarioDB =
          await perfilPreInversionBeneficiarioLocalDataSource
              .getPerfilPreInversionBeneficiarioDB(
                  perfilPreInversionId, beneficiarioId);

      return Right(perfilPreInversionBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionBeneficiariosRepositoryDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity) async {
    try {
      final result = await perfilPreInversionBeneficiarioLocalDataSource
          .savePerfilPreInversionBeneficiarios(
              perfilPreInversionBeneficiarioEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionBeneficiarioRepositoryDB(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioEntity) async {
    try {
      final perfilPreInversionBeneficiarioDB =
          await perfilPreInversionBeneficiarioLocalDataSource
              .savePerfilPreInversionBeneficiarioDB(
                  perfilPreInversionBeneficiarioEntity);
      return Right(perfilPreInversionBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesBeneficiariosProduccionDBRepositoryDB(
          List<PerfilPreInversionBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity) async {
    try {
      final result = await perfilPreInversionBeneficiarioLocalDataSource
          .updatePerfilesPreInversionesBeneficiariosProduccionDB(
              perfilesPreInversionesBeneficiariosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
