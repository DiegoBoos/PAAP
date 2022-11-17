import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

import '../../entities/perfil_beneficiario_entity.dart';
import '../../repositories/perfil_beneficiario/perfil_beneficiario_repository_db.dart';

class PerfilBeneficiarioUsecaseDB {
  final PerfilBeneficiarioRepositoryDB repositoryDB;

  PerfilBeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosUsecaseDB() {
    return repositoryDB.getPerfilBeneficiariosRepositoryDB();
  }

  Future<Either<Failure, PerfilBeneficiarioEntity?>>
      getPerfilBeneficiarioUsecaseDB(String id) {
    return repositoryDB.getPerfilBeneficiarioRepositoryDB(id);
  }

  Future<Either<Failure, int>> savePerfilBeneficiariosUsecaseDB(
      List<PerfilBeneficiarioEntity> perfilBeneficiarios) {
    return repositoryDB
        .savePerfilBeneficiariosRepositoryDB(perfilBeneficiarios);
  }
}
