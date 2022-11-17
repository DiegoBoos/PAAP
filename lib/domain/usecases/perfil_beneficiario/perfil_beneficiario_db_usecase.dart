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

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilesBeneficiariosProduccionUsecaseDB() {
    return repositoryDB.getPerfilesBeneficiariosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilBeneficiarioUsecaseDB(
      PerfilBeneficiarioEntity perfilBeneficiarioEntity) {
    return repositoryDB
        .savePerfilBeneficiarioRepositoryDB(perfilBeneficiarioEntity);
  }

  Future<Either<Failure, int>> updatePerfilesBeneficiariosProduccionUsecaseDB(
      List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity) {
    return repositoryDB.updatePerfilesBeneficiariosProduccionDBRepositoryDB(
        perfilesBeneficiariosEntity);
  }
}
