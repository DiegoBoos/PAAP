import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_experiencia_pecuaria_entity.dart';

abstract class AlianzaExperienciaPecuariaRepositoryDB {
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasProduccionRepositoryDB();

  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasRepositoryDB();

  Future<Either<Failure, AlianzaExperienciaPecuariaEntity?>>
      getAlianzaExperienciaPecuariaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId);

  Future<Either<Failure, int>> saveAlianzasExperienciasPecuariasRepositoryDB(
      List<AlianzaExperienciaPecuariaEntity> alianzasExperienciasPecuarias);

  Future<Either<Failure, int>> saveAlianzaExperienciaPecuariaRepositoryDB(
      AlianzaExperienciaPecuariaEntity experienciaPecuariaEntity);

  Future<Either<Failure, int>>
      updateAlianzasExperienciasPecuariasProduccionDBRepositoryDB(
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity);
}
