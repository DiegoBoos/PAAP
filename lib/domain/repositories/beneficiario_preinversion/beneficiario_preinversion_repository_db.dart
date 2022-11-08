import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_preinversion_entity.dart';

abstract class BeneficiarioPreinversionRepositoryDB {
  Future<Either<Failure, List<BeneficiarioPreinversionEntity>>>
      getBeneficiariosPreinversionRepositoryDB();

  Future<Either<Failure, BeneficiarioPreinversionEntity?>>
      getBeneficiarioPreinversionRepositoryDB(String id);

  Future<Either<Failure, int>> saveBeneficiariosPreinversionRepositoryDB(
      List<BeneficiarioPreinversionEntity> beneficiariopreinversionEntity);
}
