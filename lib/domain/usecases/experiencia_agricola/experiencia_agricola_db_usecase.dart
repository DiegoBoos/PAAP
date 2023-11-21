import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/experiencia_agricola_entity.dart';
import '../../repositories/experiencia_agricola/experiencia_agricola_repository_db.dart';

class ExperienciaAgricolaUsecaseDB {
  final ExperienciaAgricolaRepositoryDB repositoryDB;

  ExperienciaAgricolaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasUsecaseDB() {
    return repositoryDB.getExperienciasAgricolasRepositoryDB();
  }

  Future<Either<Failure, ExperienciaAgricolaEntity?>>
      getExperienciaAgricolaUsecaseDB(
          String tipoActividadProductivaId, String beneficiarioId) {
    return repositoryDB.getExperienciaAgricolaRepositoryDB(
        tipoActividadProductivaId, beneficiarioId);
  }

  Future<Either<Failure, int>> saveExperienciasAgricolasUsecaseDB(
      List<ExperienciaAgricolaEntity> experienciaAgricolas) {
    return repositoryDB
        .saveExperienciasAgricolasRepositoryDB(experienciaAgricolas);
  }

  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasProduccionUsecaseDB() {
    return repositoryDB.getExperienciasAgricolasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveExperienciaAgricolaUsecaseDB(
      ExperienciaAgricolaEntity experienciaAgricolaEntity) {
    return repositoryDB
        .saveExperienciaAgricolaRepositoryDB(experienciaAgricolaEntity);
  }

  Future<Either<Failure, int>> updateExperienciasAgricolasProduccionUsecaseDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity) {
    return repositoryDB.updateExperienciasAgricolasProduccionDBRepositoryDB(
        experienciasAgricolasEntity);
  }
}
