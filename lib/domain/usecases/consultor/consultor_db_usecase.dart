import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/consultor_entity.dart';
import '../../repositories/consultor/consultor_repository_db.dart';

class ConsultorUsecaseDB {
  final ConsultorRepositoryDB repositoryDB;

  ConsultorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ConsultorEntity>?>> getConsultoresUsecaseDB() {
    return repositoryDB.getConsultoresRepositoryDB();
  }

  Future<Either<Failure, ConsultorEntity?>> getConsultorUsecaseDB(String id) {
    return repositoryDB.getConsultorRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveConsultoresUsecaseDB(
      List<ConsultorEntity> consultorEntity) {
    return repositoryDB.saveConsultoresRepositoryDB(consultorEntity);
  }
}
