import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/experiencia_agricola_entity.dart';

abstract class ExperienciaAgricolaRepositoryDB {
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasProduccionRepositoryDB();

  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasRepositoryDB();

  Future<Either<Failure, ExperienciaAgricolaEntity?>>
      getExperienciaAgricolaRepositoryDB(
          String tipoActividadProductivaId, String beneficiarioId);

  Future<Either<Failure, int>> saveExperienciasAgricolasRepositoryDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolas);

  Future<Either<Failure, int>> saveExperienciaAgricolaRepositoryDB(
      ExperienciaAgricolaEntity experienciaAgricolaEntity);

  Future<Either<Failure, int>>
      updateExperienciasAgricolasProduccionDBRepositoryDB(
          List<ExperienciaAgricolaEntity> experienciasAgricolasEntity);
}
