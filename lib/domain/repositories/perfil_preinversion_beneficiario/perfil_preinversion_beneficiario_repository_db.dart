import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_beneficiario_entity.dart';

abstract class PerfilPreInversionBeneficiarioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilesPreInversionesBeneficiariosProduccionRepositoryDB();

  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionBeneficiarioEntity?>>
      getPerfilPreInversionBeneficiarioRepositoryDB(
          String perfilPreInversionId, String beneficiarioId);

  Future<Either<Failure, int>> savePerfilPreInversionBeneficiariosRepositoryDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity);
  Future<Either<Failure, int>> savePerfilPreInversionBeneficiarioRepositoryDB(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesBeneficiariosProduccionDBRepositoryDB(
          List<PerfilPreInversionBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity);
}
