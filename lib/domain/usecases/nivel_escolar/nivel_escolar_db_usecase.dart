import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/nivel_escolar_entity.dart';
import '../../repositories/nivel_escolar/nivel_escolar_repository_db.dart';

class NivelEscolarUsecaseDB {
  final NivelEscolarRepositoryDB repositoryDB;

  NivelEscolarUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<NivelEscolarEntity>?>>
      getNivelesEscolaresUsecaseDB() {
    return repositoryDB.getNivelesEscolaresRepositoryDB();
  }

  Future<Either<Failure, int>> saveNivelesEscolaresUsecaseDB(
      List<NivelEscolarEntity> nivelEscolarEntity) {
    return repositoryDB.saveNivelesEscolaresRepositoryDB(nivelEscolarEntity);
  }
}
