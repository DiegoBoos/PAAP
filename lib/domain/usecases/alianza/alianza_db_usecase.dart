import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/alianza_entity.dart';
import '../../entities/v_alianza_entity.dart';
import '../../repositories/alianza/alianza_repository_db.dart';

class AlianzaUsecaseDB {
  final AlianzaRepositoryDB repositoryDB;

  AlianzaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AlianzaEntity>?>> getAlianzasUsecaseDB() {
    return repositoryDB.getAlianzasRepositoryDB();
  }

  Future<Either<Failure, List<AlianzaEntity>?>> getAlianzasFiltrosUsecaseDB(
      String id, String nombre) {
    return repositoryDB.getAlianzasFiltrosRepositoryDB(id, nombre);
  }

  Future<Either<Failure, VAlianzaEntity?>> getAlianzaUsecaseDB(String id) {
    return repositoryDB.getAlianzaRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveAlianzasUsecaseDB(
      List<AlianzaEntity> alianzaEntity) {
    return repositoryDB.saveAlianzasRepositoryDB(alianzaEntity);
  }
}
