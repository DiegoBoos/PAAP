import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

import '../../entities/experiencia_pecuaria_entity.dart';
import '../../repositories/experiencia_pecuaria/experiencia_pecuaria_repository_db.dart';

class ExperienciaPecuariaUsecaseDB {
  final ExperienciaPecuariaRepositoryDB repositoryDB;

  ExperienciaPecuariaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasUsecaseDB() {
    return repositoryDB.getExperienciasPecuariasRepositoryDB();
  }

  Future<Either<Failure, ExperienciaPecuariaEntity?>>
      getExperienciaPecuariaUsecaseDB(String id) {
    return repositoryDB.getExperienciaPecuariaRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveExperienciasPecuariasUsecaseDB(
      List<ExperienciaPecuariaEntity> experienciaPecuarias) {
    return repositoryDB
        .saveExperienciasPecuariasRepositoryDB(experienciaPecuarias);
  }
}
