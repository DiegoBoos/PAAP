import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreinversionRepository {
  Future<Either<Failure, List<PerfilPreinversionEntity>>>
      getPerfilesPreinversionRepository(UsuarioEntity usuario);
}
