import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionCofinanciadorRubroRepository {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepository(UsuarioEntity usuario);
}
