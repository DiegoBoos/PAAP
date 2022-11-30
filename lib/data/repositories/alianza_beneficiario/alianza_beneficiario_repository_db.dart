import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/repositories/alianza_beneficiario/alianza_beneficiario_repository_db.dart';
import '../../datasources/local/alianza_beneficiario_local_ds.dart';

class AlianzaBeneficiarioRepositoryDBImpl
    implements AlianzaBeneficiarioRepositoryDB {
  final AlianzaBeneficiarioLocalDataSource alianzaBeneficiarioLocalDataSource;

  AlianzaBeneficiarioRepositoryDBImpl(
      {required this.alianzaBeneficiarioLocalDataSource});

  @override
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosProduccionRepositoryDB() async {
    try {
      final perfilesPreInversionesBeneficiariosDB =
          await alianzaBeneficiarioLocalDataSource
              .getAlianzasBeneficiariosProduccionDB();

      return Right(perfilesPreInversionesBeneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosRepositoryDB() async {
    try {
      final alianzaBeneficiariosDB =
          await alianzaBeneficiarioLocalDataSource.getAlianzasBeneficiariosDB();

      return Right(alianzaBeneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AlianzaBeneficiarioEntity?>>
      getAlianzaBeneficiarioRepositoryDB(
          String perfilPreInversionId, String beneficiarioId) async {
    try {
      final alianzaBeneficiarioDB = await alianzaBeneficiarioLocalDataSource
          .getAlianzaBeneficiarioDB(perfilPreInversionId, beneficiarioId);

      return Right(alianzaBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzasBeneficiariosRepositoryDB(
      List<AlianzaBeneficiarioEntity> alianzaBeneficiarioEntity) async {
    try {
      final result = await alianzaBeneficiarioLocalDataSource
          .saveAlianzasBeneficiarios(alianzaBeneficiarioEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAlianzaBeneficiarioRepositoryDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity) async {
    try {
      final alianzaBeneficiarioDB = await alianzaBeneficiarioLocalDataSource
          .saveAlianzaBeneficiarioDB(alianzaBeneficiarioEntity);
      return Right(alianzaBeneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updateAlianzasBeneficiariosProduccionDBRepositoryDB(
          List<AlianzaBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity) async {
    try {
      final result = await alianzaBeneficiarioLocalDataSource
          .updateAlianzasBeneficiariosProduccionDB(
              perfilesPreInversionesBeneficiariosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
