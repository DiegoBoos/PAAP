import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/beneficiario_entity.dart';
import '../../../domain/repositories/beneficiario/beneficiario_repository_db.dart';
import '../../datasources/local/beneficiario/beneficiario_local_ds.dart';

class BeneficiarioRepositoryDBImpl implements BeneficiarioRepositoryDB {
  final BeneficiarioLocalDataSource beneficiarioLocalDataSource;

  BeneficiarioRepositoryDBImpl({required this.beneficiarioLocalDataSource});

  @override
  Future<Either<Failure, List<BeneficiarioEntity>>>
      getBeneficiariosRepositoryDB() async {
    try {
      final beneficiariosDB =
          await beneficiarioLocalDataSource.getBeneficiariosDB();

      return Right(beneficiariosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveBeneficiariosRepositoryDB(
      List<BeneficiarioEntity> beneficiarioEntity) async {
    try {
      final beneficiarioDB = await beneficiarioLocalDataSource
          .saveBeneficiarios(beneficiarioEntity);
      return Right(beneficiarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
