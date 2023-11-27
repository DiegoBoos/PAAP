import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/perfil_beneficiario_entity.dart';
import '../../repositories/perfil_beneficiario/perfil_beneficiario_repository_db.dart';

class PerfilBeneficiarioUsecaseDB {
  final PerfilBeneficiarioRepositoryDB repositoryDB;

  PerfilBeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosUsecaseDB(String perfilId) {
    return repositoryDB.getPerfilBeneficiariosRepositoryDB(perfilId);
  }

  Future<Either<Failure, PerfilBeneficiarioEntity?>>
      getPerfilBeneficiarioUsecaseDB(String perfilId, String beneficiarioId) {
    return repositoryDB.getPerfilBeneficiarioRepositoryDB(
        perfilId, beneficiarioId);
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
      PerfilBeneficiarioEntity perfilBeneficiario) {
    return repositoryDB.savePerfilBeneficiarioRepositoryDB(perfilBeneficiario);
  }

  Future<Either<Failure, int>> updatePerfilesBeneficiariosProduccionUsecaseDB(
      List<PerfilBeneficiarioEntity> perfilesBeneficiarios) {
    return repositoryDB.updatePerfilesBeneficiariosProduccionDBRepositoryDB(
        perfilesBeneficiarios);
  }
}
