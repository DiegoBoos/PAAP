import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/aliado_preinversion_entity.dart';
import '../../repositories/aliado_preinversion/aliado_preinversion_repository_db.dart';

class AliadoPreinversionUsecaseDB {
  final AliadoPreinversionRepositoryDB repositoryDB;

  AliadoPreinversionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AliadoPreinversionEntity>?>>
      getAliadosPreinversionUsecaseDB() {
    return repositoryDB.getAliadosPreinversionRepositoryDB();
  }

  Future<Either<Failure, AliadoPreinversionEntity?>>
      getAliadoPreinversionUsecaseDB(String id) {
    return repositoryDB.getAliadoPreinversionRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveAliadosPreinversionUsecaseDB(
      List<AliadoPreinversionEntity> aliadosPreinversionEntity) {
    return repositoryDB
        .saveAliadosPreinversionRepositoryDB(aliadosPreinversionEntity);
  }
}
