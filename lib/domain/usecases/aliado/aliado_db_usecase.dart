import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/aliado_entity.dart';
import '../../repositories/aliado/aliado_repository_db.dart';

class AliadoUsecaseDB {
  final AliadoRepositoryDB repositoryDB;

  AliadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AliadoEntity>?>> getAliadosUsecaseDB() {
    return repositoryDB.getAliadosRepositoryDB();
  }

  Future<Either<Failure, AliadoEntity?>> getAliadoUsecaseDB(String id) {
    return repositoryDB.getAliadoRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveAliadosUsecaseDB(
      List<AliadoEntity> aliadoEntity) {
    return repositoryDB.saveAliadosRepositoryDB(aliadoEntity);
  }
}
