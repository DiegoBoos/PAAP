import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/alianza_experiencia_agricola_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AlianzaExperienciaAgricolaRepository {
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      getAlianzasExperienciasAgricolasRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<AlianzaExperienciaAgricolaEntity>>>
      saveAlianzasExperienciasAgricolasRepository(
          UsuarioEntity usuario,
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity);
}
