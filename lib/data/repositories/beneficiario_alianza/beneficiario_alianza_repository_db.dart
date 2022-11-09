import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/beneficiario_alianza_entity.dart';
import '../../../domain/repositories/beneficiario_alianza/beneficiario_alianza_repository_db.dart';
import '../../datasources/local/beneficiario_alianza/beneficiario_alianza_local_ds.dart';

class BeneficiarioAlianzaRepositoryDBImpl
    implements BeneficiarioAlianzaRepositoryDB {
  final BeneficiarioAlianzaLocalDataSource beneficiarioAlianzaLocalDataSource;

  BeneficiarioAlianzaRepositoryDBImpl(
      {required this.beneficiarioAlianzaLocalDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioAlianzaEntity>>>
      getBeneficiariosAlianzaRepositoryDB() async {
    try {
      final beneficiariosAlianzaDB =
          await beneficiarioAlianzaLocalDataSource.getBeneficiariosAlianzaDB();

      return Right(beneficiariosAlianzaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, BeneficiarioAlianzaEntity?>>
      getBeneficiarioAlianzaRepositoryDB(String id) async {
    try {
      final beneficiarioAlianzaDB =
          await beneficiarioAlianzaLocalDataSource.getBeneficiarioAlianzaDB(id);

      return Right(beneficiarioAlianzaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveBeneficiariosAlianzaRepositoryDB(
      List<BeneficiarioAlianzaEntity> beneficiarioAlianzaEntity) async {
    try {
      final result = await beneficiarioAlianzaLocalDataSource
          .saveBeneficiariosAlianza(beneficiarioAlianzaEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
