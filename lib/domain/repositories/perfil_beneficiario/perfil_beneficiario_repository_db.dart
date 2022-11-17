import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_beneficiario_entity.dart';

abstract class PerfilBeneficiarioRepositoryDB {
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosRepositoryDB();

  Future<Either<Failure, PerfilBeneficiarioEntity?>>
      getPerfilBeneficiarioRepositoryDB(String id);

  Future<Either<Failure, int>> savePerfilBeneficiariosRepositoryDB(
      List<PerfilBeneficiarioEntity> perfilBeneficiarios);
}
