import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';
import '../../repositories/beneficiario/beneficiario_repository_db.dart';

class BeneficiarioUsecaseDB {
  final BeneficiarioRepositoryDB repositoryDB;

  BeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<BeneficiarioEntity>?>> getBeneficiariosUsecaseDB(
      String perfilId) {
    return repositoryDB.getBeneficiariosRepositoryDB(perfilId);
  }

  Future<Either<Failure, BeneficiarioEntity?>> getBeneficiarioUsecaseDB(
      String id) {
    return repositoryDB.getBeneficiarioRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveBeneficiariosUsecaseDB(
      List<BeneficiarioEntity> beneficiarioEntity) {
    return repositoryDB.saveBeneficiariosRepositoryDB(beneficiarioEntity);
  }

  Future<Either<Failure, List<BeneficiarioEntity>>>
      getBeneficiariosProduccionUsecaseDB() {
    return repositoryDB.getBeneficiariosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveBeneficiarioUsecaseDB(
      BeneficiarioEntity beneficiarioEntity) {
    return repositoryDB.saveBeneficiarioRepositoryDB(beneficiarioEntity);
  }

  Future<Either<Failure, int>> updateBeneficiariosProduccionUsecaseDB(
      List<BeneficiarioEntity> beneficiariosEntity) {
    return repositoryDB
        .updateBeneficiariosProduccionDBRepositoryDB(beneficiariosEntity);
  }
}
