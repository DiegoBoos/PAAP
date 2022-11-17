import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';

abstract class BeneficiarioRepositoryDB {
  Future<Either<Failure, List<BeneficiarioEntity>>>
      getBeneficiariosRepositoryDB();
  Future<Either<Failure, List<BeneficiarioEntity>>>
      getBeneficiariosProduccionRepositoryDB();

  Future<Either<Failure, BeneficiarioEntity?>> getBeneficiarioRepositoryDB(
      String id);

  Future<Either<Failure, int>> saveBeneficiariosRepositoryDB(
      List<BeneficiarioEntity> beneficiariosEntity);

  Future<Either<Failure, int>> saveBeneficiarioRepositoryDB(
      BeneficiarioEntity beneficiarioEntity);

  Future<Either<Failure, int>> updateBeneficiariosProduccionDBRepositoryDB(
      List<BeneficiarioEntity> beneficiariosEntity);
}
