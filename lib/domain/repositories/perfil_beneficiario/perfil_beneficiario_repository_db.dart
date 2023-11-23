import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_beneficiario_entity.dart';

abstract class PerfilBeneficiarioRepositoryDB {
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilesBeneficiariosProduccionRepositoryDB();

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosRepositoryDB(String perfilId);

  Future<Either<Failure, PerfilBeneficiarioEntity?>>
      getPerfilBeneficiarioRepositoryDB(String perfilId, String beneficiarioId);

  Future<Either<Failure, int>> savePerfilBeneficiariosRepositoryDB(
      List<PerfilBeneficiarioEntity> perfilBeneficiarios);

  Future<Either<Failure, int>> savePerfilBeneficiarioRepositoryDB(
      PerfilBeneficiarioEntity perfilBeneficiarioEntity);

  Future<Either<Failure, int>>
      updatePerfilesBeneficiariosProduccionDBRepositoryDB(
          List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity);
}
