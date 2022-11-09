import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/beneficiario_preinversion_entity.dart';
import '../../../domain/repositories/beneficiario_preinversion/beneficiario_preinversion_repository_db.dart';
import '../../datasources/local/beneficiario_preinversion/beneficiario_preinversion_local_ds.dart';

class BeneficiarioPreinversionRepositoryDBImpl
    implements BeneficiarioPreinversionRepositoryDB {
  final BeneficiarioPreinversionLocalDataSource
      beneficiarioPreinversionLocalDataSource;

  BeneficiarioPreinversionRepositoryDBImpl(
      {required this.beneficiarioPreinversionLocalDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioPreinversionEntity>>>
      getBeneficiariosPreinversionRepositoryDB() async {
    try {
      final beneficiariosPreinversionDB =
          await beneficiarioPreinversionLocalDataSource
              .getBeneficiariosPreinversionDB();

      return Right(beneficiariosPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, BeneficiarioPreinversionEntity?>>
      getBeneficiarioPreinversionRepositoryDB(String id) async {
    try {
      final beneficiarioPreinversionDB =
          await beneficiarioPreinversionLocalDataSource
              .getBeneficiarioPreinversionDB(id);

      return Right(beneficiarioPreinversionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveBeneficiariosPreinversionRepositoryDB(
      List<BeneficiarioPreinversionEntity>
          beneficiarioPreinversionEntity) async {
    try {
      final result = await beneficiarioPreinversionLocalDataSource
          .saveBeneficiariosPreinversion(beneficiarioPreinversionEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
