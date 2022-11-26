import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_experiencia_agricola_entity.dart';

abstract class AlianzaExperienciaAgricolaRepositoryDB {
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasProduccionRepositoryDB();

  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasRepositoryDB();

  Future<Either<Failure, AlianzaExperienciaAgricolaEntity?>>
      getAlianzaExperienciaAgricolaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId);

  Future<Either<Failure, int>> saveAlianzasExperienciasAgricolasRepositoryDB(
      List<AlianzaExperienciaAgricolaEntity> alianzasExperienciasAgricolas);

  Future<Either<Failure, int>> saveAlianzaExperienciaAgricolaRepositoryDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity);

  Future<Either<Failure, int>>
      updateAlianzasExperienciasAgricolasProduccionDBRepositoryDB(
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity);
}
