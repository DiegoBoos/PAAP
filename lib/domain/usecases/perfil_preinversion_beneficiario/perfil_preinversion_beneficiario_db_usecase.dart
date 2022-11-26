import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../repositories/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_repository_db.dart';

class PerfilPreInversionBeneficiarioUsecaseDB {
  final PerfilPreInversionBeneficiarioRepositoryDB repositoryDB;

  PerfilPreInversionBeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>?>>
      getPerfilPreInversionBeneficiariosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionBeneficiariosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionBeneficiarioEntity?>>
      getPerfilPreInversionBeneficiarioUsecaseDB(
          String perfilPreInversionId, String beneficiarioId) {
    return repositoryDB.getPerfilPreInversionBeneficiarioRepositoryDB(
        perfilPreInversionId, beneficiarioId);
  }

  Future<Either<Failure, int>> savePerfilPreInversionBeneficiariosUsecaseDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiariosEntity) {
    return repositoryDB.savePerfilPreInversionBeneficiariosRepositoryDB(
        perfilPreInversionBeneficiariosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionBeneficiarioEntity>>>
      getPerfilesPreInversionesBeneficiariosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesBeneficiariosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionBeneficiarioUsecaseDB(
      PerfilPreInversionBeneficiarioEntity
          perfilPreInversionBeneficiarioEntity) {
    return repositoryDB.savePerfilPreInversionBeneficiarioRepositoryDB(
        perfilPreInversionBeneficiarioEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesBeneficiariosProduccionUsecaseDB(
          List<PerfilPreInversionBeneficiarioEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesBeneficiariosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
