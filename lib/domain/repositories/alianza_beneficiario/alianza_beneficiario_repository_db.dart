import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_beneficiario_entity.dart';

abstract class AlianzaBeneficiarioRepositoryDB {
  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosProduccionRepositoryDB();

  Future<Either<Failure, List<AlianzaBeneficiarioEntity>>>
      getAlianzasBeneficiariosRepositoryDB();

  Future<Either<Failure, AlianzaBeneficiarioEntity?>>
      getAlianzaBeneficiarioRepositoryDB(
          String alianzaId, String beneficiarioId);

  Future<Either<Failure, int>> saveAlianzasBeneficiariosRepositoryDB(
      List<AlianzaBeneficiarioEntity> alianzaBeneficiarioEntity);
  Future<Either<Failure, int>> saveAlianzaBeneficiarioRepositoryDB(
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity);

  Future<Either<Failure, int>>
      updateAlianzasBeneficiariosProduccionDBRepositoryDB(
          List<AlianzaBeneficiarioEntity> alianzasBeneficiariosEntity);
}
