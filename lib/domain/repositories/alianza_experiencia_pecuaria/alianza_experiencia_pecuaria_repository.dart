import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_experiencia_pecuaria_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AlianzaExperienciaPecuariaRepository {
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      getAlianzasExperienciasPecuariasRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<AlianzaExperienciaPecuariaEntity>>>
      saveAlianzasExperienciasPecuariasRepository(
          UsuarioEntity usuario,
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity);
}
