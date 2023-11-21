import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';

import '../../entities/alianza_experiencia_pecuaria_entity.dart';
import '../../repositories/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_repository_db.dart';

class AlianzaExperienciaPecuariaUsecaseDB {
  final AlianzaExperienciaPecuariaRepositoryDB repositoryDB;

  AlianzaExperienciaPecuariaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasUsecaseDB() {
    return repositoryDB.getAlianzasExperienciasPecuariasRepositoryDB();
  }

  Future<Either<Failure, AlianzaExperienciaPecuariaEntity?>>
      getAlianzaExperienciaPecuariaUsecaseDB(
          String tipoActividadProductivaId, String beneficiarioId) {
    return repositoryDB.getAlianzaExperienciaPecuariaRepositoryDB(
        tipoActividadProductivaId, beneficiarioId);
  }

  Future<Either<Failure, int>> saveAlianzasExperienciasPecuariasUsecaseDB(
      List<AlianzaExperienciaPecuariaEntity> alianzaExperienciaPecuarias) {
    return repositoryDB.saveAlianzasExperienciasPecuariasRepositoryDB(
        alianzaExperienciaPecuarias);
  }

  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasProduccionUsecaseDB() {
    return repositoryDB
        .getAlianzasExperienciasPecuariasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> saveAlianzaExperienciaPecuariaUsecaseDB(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity) {
    return repositoryDB.saveAlianzaExperienciaPecuariaRepositoryDB(
        alianzaExperienciaPecuariaEntity);
  }

  Future<Either<Failure, int>>
      updateAlianzasExperienciasPecuariasProduccionUsecaseDB(
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity) {
    return repositoryDB
        .updateAlianzasExperienciasPecuariasProduccionDBRepositoryDB(
            alianzasExperienciasPecuariasEntity);
  }
}
