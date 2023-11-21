import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

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
      getExperienciaPecuariaUsecaseDB(
          String tipoActividadProductivaId, String beneficiarioId) {
    return repositoryDB.getExperienciaPecuariaRepositoryDB(
        tipoActividadProductivaId, beneficiarioId);
  }

  Future<Either<Failure, int>> saveExperienciasPecuariasUsecaseDB(
      List<ExperienciaPecuariaEntity> experienciaPecuarias) {
    return repositoryDB
        .saveExperienciasPecuariasRepositoryDB(experienciaPecuarias);
  }

  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasProduccionUsecaseDB() {
    return repositoryDB.getExperienciasPecuariasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveExperienciaPecuariaUsecaseDB(
      ExperienciaPecuariaEntity experienciaPecuariaEntity) {
    return repositoryDB
        .saveExperienciaPecuariaRepositoryDB(experienciaPecuariaEntity);
  }

  Future<Either<Failure, int>> updateExperienciasPecuariasProduccionUsecaseDB(
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity) {
    return repositoryDB.updateExperienciasPecuariasProduccionDBRepositoryDB(
        experienciasPecuariasEntity);
  }
}
