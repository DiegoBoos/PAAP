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
      getPerfilPreInversionBeneficiarioUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionBeneficiarioRepositoryDB(id);
  }

  Future<Either<Failure, int>> savePerfilPreInversionBeneficiariosUsecaseDB(
      List<PerfilPreInversionBeneficiarioEntity>
          perfilPreInversionBeneficiariosEntity) {
    return repositoryDB.savePerfilPreInversionBeneficiariosRepositoryDB(
        perfilPreInversionBeneficiariosEntity);
  }
}
