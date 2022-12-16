import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/beneficio_entity.dart';
import '../../repositories/beneficio/beneficio_repository_db.dart';

class BeneficioUsecaseDB {
  final BeneficioRepositoryDB repositoryDB;

  BeneficioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<BeneficioEntity>?>> getBeneficiosUsecaseDB() {
    return repositoryDB.getBeneficiosRepositoryDB();
  }

  Future<Either<Failure, int>> saveBeneficiosUsecaseDB(
      List<BeneficioEntity> beneficioEntity) {
    return repositoryDB.saveBeneficiosRepositoryDB(beneficioEntity);
  }
}
