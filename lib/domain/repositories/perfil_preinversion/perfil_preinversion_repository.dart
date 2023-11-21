import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionRepository {
  Future<Either<Failure, List<PerfilPreInversionEntity>>>
      getPerfilesPreInversionRepository(UsuarioEntity usuario);
}
