import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/beneficiario_alianza_entity.dart';

abstract class BeneficiarioAlianzaRepositoryDB {
  Future<Either<Failure, List<BeneficiarioAlianzaEntity>>>
      getBeneficiariosAlianzaRepositoryDB();

  Future<Either<Failure, BeneficiarioAlianzaEntity?>>
      getBeneficiarioAlianzaRepositoryDB(String id);

  Future<Either<Failure, int>> saveBeneficiariosAlianzaRepositoryDB(
      List<BeneficiarioAlianzaEntity> beneficiarioalianzaEntity);
}
