import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionCofinanciadorRepository {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresRepository(UsuarioEntity usuario);
}
