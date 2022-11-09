import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/beneficiario_alianza_entity.dart';
import '../../repositories/beneficiario_alianza/beneficiario_alianza_repository_db.dart';

class BeneficiarioAlianzaUsecaseDB {
  final BeneficiarioAlianzaRepositoryDB repositoryDB;

  BeneficiarioAlianzaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<BeneficiarioAlianzaEntity>?>>
      getBeneficiariosAlianzaUsecaseDB() {
    return repositoryDB.getBeneficiariosAlianzaRepositoryDB();
  }

  Future<Either<Failure, BeneficiarioAlianzaEntity?>>
      getBeneficiarioAlianzaUsecaseDB(String id) {
    return repositoryDB.getBeneficiarioAlianzaRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveBeneficiariosAlianzaUsecaseDB(
      List<BeneficiarioAlianzaEntity> beneficiariosAlianzaEntity) {
    return repositoryDB
        .saveBeneficiariosAlianzaRepositoryDB(beneficiariosAlianzaEntity);
  }
}
