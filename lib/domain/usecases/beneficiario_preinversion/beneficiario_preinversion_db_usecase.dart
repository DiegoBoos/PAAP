import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/beneficiario_preinversion_entity.dart';
import '../../repositories/beneficiario_preinversion/beneficiario_preinversion_repository_db.dart';

class BeneficiarioPreinversionUsecaseDB {
  final BeneficiarioPreinversionRepositoryDB repositoryDB;

  BeneficiarioPreinversionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<BeneficiarioPreinversionEntity>?>>
      getBeneficiariosPreinversionUsecaseDB() {
    return repositoryDB.getBeneficiariosPreinversionRepositoryDB();
  }

  Future<Either<Failure, BeneficiarioPreinversionEntity?>>
      getBeneficiarioPreinversionUsecaseDB(String id) {
    return repositoryDB.getBeneficiarioPreinversionRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveBeneficiariosPreinversionUsecaseDB(
      List<BeneficiarioPreinversionEntity> beneficiariosPreinversionEntity) {
    return repositoryDB.saveBeneficiariosPreinversionRepositoryDB(
        beneficiariosPreinversionEntity);
  }
}
