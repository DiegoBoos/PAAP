import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/experiencia_agricola_entity.dart';

abstract class ExperienciaAgricolaRepositoryDB {
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasRepositoryDB();

  Future<Either<Failure, ExperienciaAgricolaEntity?>>
      getExperienciaAgricolaRepositoryDB(String id);

  Future<Either<Failure, int>> saveExperienciasAgricolasRepositoryDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolas);
}
