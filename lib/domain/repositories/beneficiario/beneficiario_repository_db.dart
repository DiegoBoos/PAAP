import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';

abstract class BeneficiarioRepositoryDB {
  Future<Either<Failure, List<BeneficiarioEntity>>>
      getBeneficiariosRepositoryDB();

  Future<Either<Failure, BeneficiarioEntity?>> getBeneficiarioRepositoryDB(
      String id);

  Future<Either<Failure, int>> saveBeneficiariosRepositoryDB(
      List<BeneficiarioEntity> beneficiarioEntity);
}
