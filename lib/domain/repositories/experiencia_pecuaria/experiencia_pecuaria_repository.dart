import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/experiencia_pecuaria_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ExperienciaPecuariaRepository {
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      saveExperienciasPecuariasRepository(UsuarioEntity usuario,
          List<ExperienciaPecuariaEntity> experienciasPecuariasEntity);
}
