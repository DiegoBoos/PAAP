import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/opcion_entity.dart';
import '../../repositories/opcion/opcion_repository_db.dart';

class OpcionUsecaseDB {
  final OpcionRepositoryDB repositoryDB;

  OpcionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<OpcionEntity>?>> getOpcionesUsecaseDB() {
    return repositoryDB.getOpcionesRepositoryDB();
  }

  Future<Either<Failure, int>> saveOpcionesUsecaseDB(
      List<OpcionEntity> opcionEntity) {
    return repositoryDB.saveOpcionesRepositoryDB(opcionEntity);
  }
}
