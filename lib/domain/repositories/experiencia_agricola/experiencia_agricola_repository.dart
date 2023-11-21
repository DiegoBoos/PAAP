import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/experiencia_agricola_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ExperienciaAgricolaRepository {
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      saveExperienciasAgricolasRepository(UsuarioEntity usuario,
          List<ExperienciaAgricolaEntity> experienciasAgricolasEntity);
}
