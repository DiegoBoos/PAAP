import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/beneficiario_entity.dart';
import '../../repositories/beneficiario/beneficiario_repository_db.dart';

class BeneficiarioUsecaseDB {
  final BeneficiarioRepositoryDB repositoryDB;

  BeneficiarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<BeneficiarioEntity>?>>
      getBeneficiariosUsecaseDB() {
    return repositoryDB.getBeneficiariosRepositoryDB();
  }

  Future<Either<Failure, BeneficiarioEntity?>> getBeneficiarioUsecaseDB(
      String id) {
    return repositoryDB.getBeneficiarioRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveBeneficiariosUsecaseDB(
      List<BeneficiarioEntity> beneficiarioEntity) {
    return repositoryDB.saveBeneficiariosRepositoryDB(beneficiarioEntity);
  }
}
