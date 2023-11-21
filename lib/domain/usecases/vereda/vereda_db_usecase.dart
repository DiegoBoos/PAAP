import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/vereda_entity.dart';
import '../../repositories/vereda/vereda_repository_db.dart';

class VeredaUsecaseDB {
  final VeredaRepositoryDB repositoryDB;

  VeredaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<VeredaEntity>?>> getVeredasByMunicipioUsecaseDB(
      String municipioId) {
    return repositoryDB.getVeredasByMunicipioRepositoryDB(municipioId);
  }

  Future<Either<Failure, int>> saveVeredasUsecaseDB(
      List<VeredaEntity> veredaEntity) {
    return repositoryDB.saveVeredasRepositoryDB(veredaEntity);
  }
}
