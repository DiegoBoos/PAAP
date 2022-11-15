import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_beneficiario_entity.dart';

abstract class PerfilPreInversionBeneficiarioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilPreInversionBeneficiariosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionBeneficiarioEntity?>>
      getPerfilPreInversionBeneficiarioRepositoryDB(String id);

  Future<Either<Failure, int>> savePerfilPreInversionBeneficiariosRepositoryDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiarioEntity);
}
