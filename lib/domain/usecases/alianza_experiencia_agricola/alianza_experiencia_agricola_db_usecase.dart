import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/alianza_experiencia_agricola_entity.dart';
import '../../repositories/alianza_experiencia_agricola/alianza_experiencia_agricola_repository_db.dart';

class AlianzaExperienciaAgricolaUsecaseDB {
  final AlianzaExperienciaAgricolaRepositoryDB repositoryDB;

  AlianzaExperienciaAgricolaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasUsecaseDB() {
    return repositoryDB.getAlianzasExperienciasAgricolasRepositoryDB();
  }

  Future<Either<Failure, AlianzaExperienciaAgricolaEntity?>>
      getAlianzaExperienciaAgricolaUsecaseDB(
          String tipoActividadProductivaId, String beneficiarioId) {
    return repositoryDB.getAlianzaExperienciaAgricolaRepositoryDB(
        tipoActividadProductivaId, beneficiarioId);
  }

  Future<Either<Failure, int>> saveAlianzasExperienciasAgricolasUsecaseDB(
      List<AlianzaExperienciaAgricolaEntity> alianzaExperienciaAgricolas) {
    return repositoryDB.saveAlianzasExperienciasAgricolasRepositoryDB(
        alianzaExperienciaAgricolas);
  }

  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasProduccionUsecaseDB() {
    return repositoryDB
        .getAlianzasExperienciasAgricolasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveAlianzaExperienciaAgricolaUsecaseDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity) {
    return repositoryDB.saveAlianzaExperienciaAgricolaRepositoryDB(
        alianzaExperienciaAgricolaEntity);
  }

  Future<Either<Failure, int>>
      updateAlianzasExperienciasAgricolasProduccionUsecaseDB(
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity) {
    return repositoryDB
        .updateAlianzasExperienciasAgricolasProduccionDBRepositoryDB(
            alianzasExperienciasAgricolasEntity);
  }
}
