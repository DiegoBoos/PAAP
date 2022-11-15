import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionAliadoRepository {
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosRepository(UsuarioEntity usuario);
}
